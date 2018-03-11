import Foundation

// MARK: - FlowContainer
public protocol FlowContainer: Container {
    func addNode<S: Navigatable>(_ type: S.Type, factory: @escaping (Resolver) -> S) -> WorkflowNode<S> where S.In == Void
    func addNode<S: Navigatable>(_ type: S.Type, input: S.In.Type, factory: @escaping (Resolver, S.In) -> S) -> WorkflowNode<S>
}

// MARK: - WorkflowType
public protocol WorkflowType: FlowContainer { }

// MARK: - Workflow
/// Base Workflow class. All workflows should inhrit from it.
open class Workflow: FlowContainer, WorkflowType {
    public static var start = Transition<Void>()

    var nodes: [Any] = []
    public var parent: Container?
    public var registrations: [RegsteredInstance]  = []
    public var workflow: WorkflowType?

    fileprivate var connectors: [String: Any] = [:]
    fileprivate var name: String { return String(describing: self) }

    public weak var view: ViewType!
    public weak var flowNavigation: NavigationProvider!

    public init() {
        if self is NavigationProvider {
            flowNavigation = self as? NavigationProvider
        }
        debugPrint("Init workflow: \(String(describing: self))")
        build()
    }

    deinit {
        debugPrint("[W] Released \(String(describing: self))")
    }

    open func build() {
    }

    open func assemble(in parent: Container) {
        debugPrint("Assembled workflow: \(String(describing: self))")
        self.parent = parent
    }
}

// MARK: - Initial State and Start
extension Navigatable where Self: Workflow {
    /// Simple entry point, when transition matches workflow In, and flow is Void
    ///
    /// - Parameters:
    ///   - node: initial node
    ///   - transition: transition
    ///   - connector: allows to specify main workflow view for this entrance
    public func setEntry<New>(_ node: WorkflowNode<New>, for transition: Transition<In>, connector: @escaping (In,New) -> ViewType) where New.In == Void {
        bridgeEntry(node, for: transition, bridge: { _ in }, connector: connector)
    }

    /// Entry point, where transitions arguments matches flow input
    ///
    /// - Parameters:
    ///   - node: initial node
    ///   - transition: transition
    ///   - connector: allows to specify main workflow view for this entrance
    public func setEntry<New,Arg>(_ node: WorkflowNode<New>, for transition: Transition<Arg>, connector: @escaping (Arg,New) -> ViewType) where New.In == Arg {
        bridgeEntry(node, for: transition, bridge: { $0 }, connector: connector)
    }

    /// Entry point, when transition Arg and initial flow In do not match
    ///
    /// - Parameters:
    ///   - node: initial node
    ///   - transition: transition
    ///   - bridge: transform transition arguments into flow input
    ///   - connector: allows to specify main workflow view for this entrance
    public func bridgeEntry<New,Arg>(_ node: WorkflowNode<New>, for transition: Transition<Arg>, bridge: @escaping (Arg) -> New.In, connector: @escaping (Arg,New) -> ViewType) {
        let intro: (Arg) -> ViewType = { [weak self] output in
            let input = bridge(output)
            let destination = node.resolve(with: input) // keep destination node alive
            let view = connector(output, destination)   // connecor returns initial main view
            self?.view = view                           // set the mani view for workflow
            return view
        }
        connectors[transition.id] = intro
        debugPrint("[\(String(describing: self))] adding initial \(node.name) for \(transition.name)")
    }

    /// Start workflow with argumetns from given transition.
    ///
    /// - Parameters:
    ///   - transition: Entry transition
    ///   - argument: Entry parameters
    /// - Returns: Workflow main view
    /// - Throws: TransitionError if not set or wronf type
    @discardableResult public func start<Arg>(with transition: Transition<Arg>, and argument: Arg) -> ViewType {
        do {
            guard let registered = connectors[transition.id] else {
                throw TransitionError.notSet
            }

            if let intro = registered as? (Arg) -> ViewType {
                return intro(argument)
            } else {
                throw TransitionError.wrongType
            }
        } catch {
            debugPrint("[W] Start error in \(name): \(String(describing: error)) for \(transition.name)")
            fatalError("[W] Start error in \(name): \(String(describing: error)) for \(transition.name)")
        }
    }
}

extension Navigatable where Self: Workflow, In == Void {
    /// Default entry point, where all transitions arguments are Void
    ///
    /// - Parameters:
    ///   - node: initial node
    ///   - connector: allows to specify main workflow view for this entrance
    public func setEntry<New>(_ node: WorkflowNode<New>, connector: @escaping (New) -> ViewType) where New.In == Void {
        bridgeEntry(node, for: Workflow.start, bridge: { _ in }) { _, new -> ViewType in
            return connector(new)
        }
    }

    /// Simple entry point, where all transitions arguments are Void
    ///
    /// - Parameters:
    ///   - node: initial node
    ///   - transition: transition
    ///   - connector: allows to specify main workflow view for this entrance
    public func setEntry<New>(_ node: WorkflowNode<New>, for transition: Transition<Void>, connector: @escaping (New) -> ViewType) where New.In == Void {
        bridgeEntry(node, for: transition, bridge: { _ in }) { _, new -> ViewType in
            return connector(new)
        }
    }

    /// Start workflow with given transition.
    ///
    /// - Parameter transition: Entry Transition
    /// - Returns: Workflow main view
    /// - Throws: TransitionError if not set or wronf type
    @discardableResult public func start() -> ViewType {
        return start(with: Workflow.start, and: ())
    }

    /// Start workflow with given transition.
    ///
    /// - Parameter transition: Entry Transition
    /// - Returns: Workflow main view
    /// - Throws: TransitionError if not set or wronf type
    @discardableResult public func start(with transition: Transition<Void>) -> ViewType {
        return start(with: transition, and: ())
    }
}

// MARK: - Registration
extension Workflow {
    class Registration<S: Navigatable> {
        private var factory: (S.In) -> S
        private var name: String { return String(describing: S.self) }
        weak private var instance: S?

        init(factory: @escaping (S.In) -> S) {
            debugPrint("[R] Registered connector for \(String(describing: S.self))")
            self.factory = factory
        }

        deinit {
            debugPrint("[R] Releasing registration for \(String(describing: S.self))")
        }

        func build(with input: S.In) -> S {
            debugPrint(instance != nil ? "[R] Using existing instance of \(name)" : "[R] Building new instance of \(name)")
            let resolved = instance ?? factory(input)
            instance = resolved
            return resolved
        }
    }

    /// Adds new node into graph. Node is strong referenced by a graph.
    ///
    /// - Parameters:
    ///   - type: Node type, that will be wrapped in registration
    ///   - factory: Transform In type into instance
    /// - Returns: Node<Type>, as connectable instance. Can be used to connect top other instances
    public func addNode<S: Navigatable>(_ type: S.Type, factory: @escaping (Resolver) -> S) -> WorkflowNode<S> where S.In == Void {
        return addNode(type, input: S.In.self, factory: { (resolver, _) -> S in
            return factory(resolver)
        })
    }

    /// Adds new node into graph, that requires parameters. Node is strong referenced by a graph.
    ///
    /// - Parameters:
    ///   - type: Node type, that will be wrapped in registration
    ///   - input: Input type passed into factory
    ///   - factory: Transform In type into instance
    /// - Returns: Node<Type>, as connectable instance. Can be used to connect top other instances
    public func addNode<S: Navigatable>(_ type: S.Type, input: S.In.Type, factory: @escaping (Resolver, S.In) -> S) -> WorkflowNode<S> {
        let make: (S.In) -> S = { [unowned self] input in
            let instance = factory(self, input)
            instance.workflow = self    // keep workflow around while flow is around
            if let container = instance as? Container {
                container.assemble(in: self)
            }
            return instance
        }

        let node = WorkflowNode<S>(Registration<S>(factory: make))
        nodes.append(node)
        debugPrint("[\(name)] adding \(node.name)")
        return node
    }
}

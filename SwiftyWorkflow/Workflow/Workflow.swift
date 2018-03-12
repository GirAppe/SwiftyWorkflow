import Foundation

// MARK: - FlowContainer
public protocol FlowContainer: Container {
}

// MARK: - WorkflowType
public protocol WorkflowType: FlowContainer { }

// MARK: - Workflow
/// Base Workflow class. All workflows should inhrit from it.
open class Workflow: FlowContainer, WorkflowType {
    public static var start = Transition<Void>("[W] startWorkflow")
    public static var end = Transition<Void>("[W] endWorkflow")
    public static var cancel = Transition<Void>("[W] cancelWorkflow")

    public var parent: Container?
    public var registrations: [RegsteredInstance]  = []
    public var workflow: WorkflowType?

    open weak var view: ViewType!
    public weak var flowNavigation: NavigationProvider!

    fileprivate var nodes: [Any] = []
    fileprivate let id: String = UUID().uuidString
    fileprivate var connectors: [String: Any] = [:]
    fileprivate var name: String { return String(describing: self) }

    public init() {
        if self is NavigationProvider {
            flowNavigation = self as? NavigationProvider
        }
        debugPrint("Init workflow: \(String(describing: self))")
        build()
        connect()
        validate()
    }

    deinit {
        debugPrint("[W] Released \(String(describing: self))")
    }

    open func build() {
    }

    open func connect() {
    }

    open func validate() {
    }

    open func assemble(in parent: Container) {
        debugPrint("Assembled workflow: \(String(describing: self))")
        self.parent = parent
    }
}

// MARK: - Starting Point
extension Navigatable where Self: Workflow {
    public func starts<New>(with node: WorkflowNode<New>) where New.In == Self.In {
        starts(with: node, bridge: { $0 }) { _, flow -> ViewType in
            return flow.view
        }
    }

    public func starts<New>(with node: WorkflowNode<New>, connector: @escaping (Self.In,New) -> ViewType) where New.In == Self.In {
        starts(with: node, bridge: { $0 }, connector: connector)
    }

    public func starts<New>(with node: WorkflowNode<New>, wrap: Bool) where New.In == Self.In {
        starts(with: node, bridge: { $0 }) { _, flow -> ViewType in
            return wrap ? flow.view!.wrappedInNavigation() : flow.view!
        }
    }

    public func starts<New>(with node: WorkflowNode<New>, bridge: @escaping (Self.In) -> New.In, connector: @escaping (Self.In,New) -> ViewType) {
        let transition = Workflow.start
        let intro: (Self.In) -> ViewType = { [weak self] output in
            let input = bridge(output)
            let destination = node.resolve(with: input) // keep destination node alive
            let view = connector(output, destination)   // connecor returns initial main view
            self?.view = view                           // set the mani view for workflow
            return view
        }
        connectors[transition.id] = intro
        debugPrint("[\(String(describing: self))] adding initial \(node.name) for \(transition.name)")
    }
}

// MARK: - Starting Flow
extension Navigatable where Self: Workflow {
    /// Start workflow with argumetns from given transition.
    ///
    /// - Parameters:
    ///   - transition: Entry transition
    ///   - argument: Entry parameters
    /// - Returns: Workflow main view
    /// - Throws: TransitionError if not set or wronf type
    @discardableResult public func start(with parameter: Self.In) -> ViewType {
        let transition = Workflow.start
        do {
            guard let registered = connectors[transition.id] else {
                throw TransitionError.notSet
            }

            if let intro = registered as? (Self.In) -> ViewType {
                return intro(parameter)
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
    /// Start workflow with given transition.
    ///
    /// - Parameter transition: Entry Transition
    /// - Returns: Workflow main view
    /// - Throws: TransitionError if not set or wronf type
    @discardableResult public func start() -> ViewType {
        return start(with: ())
    }
}

// MARK: - Registration
extension Workflow {
    class Registration<S: Navigatable> {
        private var factory: (S.In) -> S
        private var name: String { return String(describing: S.self) }
        private(set) weak var instance: S?

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
    public func add<S: Navigatable>(_ type: S.Type, factory: @escaping (Resolver) -> S) -> WorkflowNode<S> where S.In == Void {
        return add(type, input: S.In.self, factory: { (resolver, _) -> S in
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
    public func add<S: Navigatable>(_ type: S.Type, input: S.In.Type, factory: @escaping (Resolver, S.In) -> S) -> WorkflowNode<S> {
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

import Foundation

protocol WorkflowContainerType: class, ContainerType {
    func registerFlow<S: FlowController>(_ type: S.Type, factory:  @escaping (WorkflowContainerType, S.In) -> S) -> WorkflowNode<S>
}

// MARK: - WorkflowType
protocol WorkflowType {
    // head flow
    // maybe stack? need to be notified from Node to push to stack, but problem with pop will arise...
}

// MARK: - WorkflowController
protocol FlowController: class {
    associatedtype In
    associatedtype Out

    weak var view: ViewType! { get }
    weak var flowNavigation: NavigationProvider! { get set }

    func perform(_ transition: Transition<Void>)
    func perform<Arg>(_ transition: Transition<Arg>, with argument: Arg)
}

extension FlowController {
    func perform(_ transition: Transition<Void>) {
        perform(transition, with: ())
    }
    func perform<Arg>(_ transition: Transition<Arg>, with argument: Arg) {
        do {
            try flowNavigation?.move(transition, with: argument, from: self)
        } catch {
            debugPrint("Transition failed: \(String(describing: error))")
            assertionFailure("Transition failed: \(String(describing: error))")
        }
    }
}

// MARK: - Workflow
/// Base Workflow class. All workflows should inhrit from it.
class Workflow: WorkflowContainerType, WorkflowType {
    var nodes: [Any] = []
    var parent: ContainerType?
    var registrations: [RegsteredInstance]  = []
}

// MARK: - Registration
extension Workflow {
    class Registration<S: FlowController> {
        private var factory: (S.In) -> S
        weak private var instance: S?

        init(factory: @escaping (S.In) -> S) {
            self.factory = factory
        }

        func build(with input: S.In) -> S {
            let resolved = instance ?? factory(input)
            instance = resolved
            return resolved
        }
    }

    func registerFlow<S: FlowController>(_ type: S.Type, factory: @escaping (WorkflowContainerType, S.In) -> S) -> WorkflowNode<S> {
        let make: (S.In) -> S = { [unowned self] input in
            return factory(self, input)
        }

        let node = WorkflowNode<S>(Registration<S>(factory: make))
        nodes.append(node)
        return node
    }
}

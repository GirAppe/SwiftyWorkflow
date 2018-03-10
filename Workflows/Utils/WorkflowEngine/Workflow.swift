import Foundation

protocol FlowContainer: Container {
    func setNode<S: FlowConnector>(_ type: S.Type, factory: @escaping (Resolver) -> S) -> WorkflowNode<S> where S.In == Void
    func setNode<S: FlowConnector>(_ type: S.Type, input: S.In.Type, factory: @escaping (Resolver, S.In) -> S) -> WorkflowNode<S>
}

// MARK: - WorkflowType
protocol WorkflowType {
    // head flow
    // maybe stack? need to be notified from Node to push to stack, but problem with pop will arise...
}

// MARK: - Workflow
/// Base Workflow class. All workflows should inhrit from it.
class Workflow: FlowContainer, WorkflowType {
    var nodes: [Any] = []
    var parent: Container?
    var registrations: [RegsteredInstance]  = []

    init() {
        build()
    }

    func build() {
    }

    func assemble(in parent: Container) {
        self.parent = parent
    }
}

// MARK: - Registration
extension Workflow {
    class Registration<S: FlowConnector> {
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

    func setNode<S: FlowConnector>(_ type: S.Type, factory: @escaping (Resolver) -> S) -> WorkflowNode<S> where S.In == Void {
        return setNode(type, input: S.In.self, factory: { (resolver, _) -> S in
            return factory(resolver)
        })
    }

    func setNode<S: FlowConnector>(_ type: S.Type, input: S.In.Type, factory: @escaping (Resolver, S.In) -> S) -> WorkflowNode<S> {
        let make: (S.In) -> S = { [unowned self] input in
            let instance = factory(self, input)
            if let container = instance as? Container {
                container.assemble(in: self)
            }
            return instance
        }

        let node = WorkflowNode<S>(Registration<S>(factory: make))
        nodes.append(node)
        return node
    }
}

import Foundation

protocol FlowContainer: Container {
    func registerFlow<S: FlowConnector>(_ type: S.Type, factory:  @escaping (Resolver, S.In) -> S) -> WorkflowNode<S>
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

    func registerFlow<S: FlowConnector>(_ type: S.Type, factory: @escaping (Resolver, S.In) -> S) -> WorkflowNode<S> {
        let make: (S.In) -> S = { [unowned self] input in
            return factory(self, input)
        }

        let node = WorkflowNode<S>(Registration<S>(factory: make))
        nodes.append(node)
        return node
    }
}

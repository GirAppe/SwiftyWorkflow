import Foundation

class WorkflowNode<S: FlowController> {
    let id: ID = UUID().uuidString
    private let registration: Workflow.Registration<S>
    private var connectors: [String: Any] = [:]

    init(_ registration: Workflow.Registration<S>) {
        self.registration = registration
    }

    private func resolve(with input: S.In) -> S {
        let controller = registration.build(with: input)
        controller.flowNavigation = self
        return controller
    }

    func connect<New>(to node: WorkflowNode<New>, for transation: Transition<Void>, connector: @escaping (S,New) -> Void) where New.In == Void {
        bridge(to: node, for: transation, bridge: { }, connector: connector)
    }

    func connect<New, Arg>(to node: WorkflowNode<New>, for transation: Transition<Arg>, connector: @escaping (S,New) -> Void) where New.In == Arg {
        bridge(to: node, for: transation, bridge: { $0 }, connector: connector)
    }

    func bridge<New, Arg>(to node: WorkflowNode<New>, for transation: Transition<Arg>, bridge: @escaping (Arg) -> New.In, connector: @escaping (S,New) -> Void) {
        let connect: (Arg,S) -> Void = { output, source in
            let input = bridge(output)
            let destination = node.resolve(with: input) // keep destination node alive
            connector(source, destination)
        }
        connectors[transation.id] = connect
    }

    func end<F>(flow: F, with transition: Transition<Void>, outro: @escaping (F) -> Void) where F: WorkflowType, F: FlowController {
        end(flow: flow, with: transition, outro: { flow, _ in outro(flow) })
    }

    func end<F,Arg>(flow: F, with transition: Transition<Arg>, outro: @escaping (F,Arg) -> Void) where F: WorkflowType, F: FlowController {
        let ending: (Arg) -> Void = { argument in
            outro(flow, argument)
        }
        connectors[transition.id] = ending
    }
}

// MARK: - NavigationProvider
extension WorkflowNode: NavigationProvider{
    func move<S>(_ transition: Transition<Void>, from source: S) throws {
        try move(transition, with: (), from: source)
    }

    func move<Arg,S>(_ transition: Transition<Arg>, with argument: Arg, from source: S) throws {
        guard let registered = connectors[transition.id] else {
            throw TransitionError.notSet
        }

        if let connector = registered as? (Arg,S) -> Void {
            connector(argument,source)
        } else if let outro = registered as? (Arg) -> Void {
            outro(argument)
        } else {
            throw TransitionError.wrongType
        }
    }
}

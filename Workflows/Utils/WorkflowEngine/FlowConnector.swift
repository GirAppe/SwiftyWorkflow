import Foundation

// MARK: - FlowConnector
protocol FlowConnector: class {
    associatedtype In
    associatedtype Out

    weak var view: ViewType! { get }
    /// Set automatically by WorkflowEngine - do not set manually!!!
    weak var flowNavigation: NavigationProvider! { get set }

    func perform(_ transition: Transition<Void>)
    func perform<Arg>(_ transition: Transition<Arg>, with argument: Arg)
}

extension FlowConnector {
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

import Foundation

protocol Navigatable: class {
    associatedtype In
    associatedtype Out

    weak var view: ViewType! { get }
    weak var flowNavigation: NavigationProvider! { get set }
    var workflow: WorkflowType? { get set }

    func perform(_ transition: Transition<Void>)
    func perform<Arg>(_ transition: Transition<Arg>, with argument: Arg)
}

extension Navigatable {
    func perform(_ transition: Transition<Void>) {
        perform(transition, with: ())
    }
    func perform<Arg>(_ transition: Transition<Arg>, with argument: Arg) {
        do {
            try flowNavigation?.move(transition, with: argument, from: self)
        } catch {
            debugPrint("[T] Transition \(transition.name) failed: \(String(describing: error))")
            assertionFailure("Transition \(transition.name) failed: \(String(describing: error))")
        }
    }
}

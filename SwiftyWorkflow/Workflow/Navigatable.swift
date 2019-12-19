import Foundation

public protocol Navigatable: class {
    associatedtype In
    associatedtype Out: TransitionConvertible

    var view: ViewType! { get }
    var flowNavigation: NavigationProvider! { get set }
    var workflow: WorkflowType? { get set }

    func perform(_ transition: Self.Out)
    func perform<Arg>(_ transition: Self.Out, with argument: Arg)
}

public extension Navigatable {
    func perform(_ transition: Self.Out) {
        perform(transition, with: ())
    }
    
    func perform<Arg>(_ transition: Self.Out, with argument: Arg) {
        do {
            guard let transition: Transition<Arg> = transition.asTransition() else {
                throw TransitionError.wrongType
            }
            try flowNavigation?.move(transition, with: argument, from: self)
        } catch {
            debugPrint("[T] Transition \(transition.name) failed: \(String(describing: error))")
            assertionFailure("Transition \(transition.name) failed: \(String(describing: error))")
        }
    }
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

import Foundation

/// Standard completion closure for navigation operation
public typealias NavigationCompletion = () -> Swift.Void

//sourcery: AutoMockable
public protocol ViewType: class {
    /// Presenting view. If view is a part of navigation controller hierarchy - returns navigation presenting view
    var presentingView: ViewType? { get }
    /// Presented view. If view is a part of navigation controller hierarchy - returns navigation presented view
    var presentedView: ViewType? { get }
    /// Self if view is navigation view, Navigation controller or parents navigation controller otherwise
    var navigationView: ViewType? { get }
    /// Default error handling closure
    var handleError: (Error) -> Void { get }

    // Navigation stack
    func push(_ view: ViewType, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func pop(to source: ViewType, animated: Bool)
    // Modal
    func present(_ view: ViewType, animated flag: Bool)
    func present(_ view: ViewType, animated flag: Bool, completion: NavigationCompletion?)
    func present(error: Error)
    func dismiss(animated flag: Bool)
    func dismiss(animated flag: Bool, completion: NavigationCompletion?)
    // Other
    func replace(_ view: ViewType, animated: Bool)

    // Helpers
    func wrappedInNavigation() -> ViewType
}

public extension ViewType {
    var presentingView: ViewType? { return nil }
    var presentedView: ViewType? { return nil }
    var navigationView: ViewType? { return nil }
    var handleError: (Error) -> Void { return { self.present(error: $0) } }

    func dismiss(animated flag: Bool) {
        dismiss(animated: flag, completion: nil)
    }
}


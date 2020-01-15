// MARK: - NavigationContext

#if os(iOS) || os(tvOS)
import UIKit
#endif

//sourcery: AutoMockable
public protocol NavigationContext: class {

    // MARK: - Properties

    /// Presenting context. If context is a part of navigation controller hierarchy - returns navigation presenting context
    var presentingContext: NavigationContext? { get }
    /// Presented context. If context is a part of navigation controller hierarchy - returns navigation presented context
    var presentedContext: NavigationContext? { get }
    /// Self if context is navigation context, Navigation controller or parents navigation controller otherwise
    var navigationContext: NavigationContext? { get }
    /// Default error handling closure
    var handleError: (Error) -> Void { get }

    // MARK: - Navigation stack operations

    func push(_ context: NavigationContext, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func pop(to source: NavigationContext, animated: Bool)

    // MARK: - Modal presenttion operations

    func present(_ context: NavigationContext, animated flag: Bool)
    func present(_ context: NavigationContext, animated flag: Bool, completion: NavigationCompletion?)
    func present(error: Error)
    func dismiss(animated flag: Bool)
    func dismiss(animated flag: Bool, completion: NavigationCompletion?)

    // MARK: - Helpers

    func wrappedInNavigation() -> NavigationContext
    func wrappedIn(_ navigation: NavigationContext) -> NavigationContext

    #if os(iOS) || os(tvOS)
    func withModalPresentationStyle(_ style: UIModalPresentationStyle) -> NavigationContext
    #endif

    // MARK: - Workflows operations

    @discardableResult
    func present<W: Workflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool,
        completion: NavigationCompletion?
    ) -> W

    @discardableResult
    func push<W: Workflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool
    ) -> W
}

// MARK: - Default implementations

public extension NavigationContext {

    var presentingContext: NavigationContext? { return nil }
    var presentedContext: NavigationContext? { return nil }
    var navigationContext: NavigationContext? { return nil }
    var handleError: (Error) -> Void { return { self.present(error: $0) } }

    func dismiss(animated flag: Bool = true) {
        dismiss(animated: flag, completion: nil)
    }
}

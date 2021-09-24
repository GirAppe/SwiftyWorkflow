// MARK: - NavigationContext

import Foundation
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

    /// Pushes new context onto existing context.
    /// - Parameters:
    ///   - context: Context to push
    ///   - animated: Animate trransition
    func push(_ context: NavigationContext, animated: Bool)

    /// Pop one context from stack.
    /// - Parameter animated: Animate transition
    func pop(animated: Bool)

    /// Pop to root context in stack.
    /// - Parameter animated: Animate transition
    func popToRoot(animated: Bool)

    /// Pops to specified context if possible.
    /// - Parameters:
    ///   - source: Context to pop to
    ///   - animated: Animate transition
    func pop(to source: NavigationContext, animated: Bool)

    // MARK: - Modal presenttion operations

    /// Presents new context modally.
    /// - Parameters:
    ///   - context: Context to present
    ///   - flag: Animate transition
    func present(_ context: NavigationContext, animated flag: Bool)

    /// Presents new context modally with completion.
    /// - Parameters:
    ///   - context: Context to present
    ///   - flag: Animate transition
    ///   - completion: Completion block
    func present(_ context: NavigationContext, animated flag: Bool, completion: NavigationCompletion?)

    /// Invokes default error handler. By default, it shows UIAlertController (for UIViewControllers)
    /// - Parameter error: Error to present
    func present(error: Error)

    /// Dismisses context
    /// - Parameter flag: Animate transition
    func dismiss(animated flag: Bool)

    /// Dismisses context with completion
    /// - Parameters:
    ///   - flag: Animate transition
    ///   - completion: Completion block
    func dismiss(animated flag: Bool, completion: NavigationCompletion?)

    // MARK: - Helpers

    /// Wraps context in default navigation context (like UINavigationController subclass)
    func wrappedInNavigation() -> NavigationContext

    /// Wrpas context in specified navigation context
    /// - Parameter navigation: Navigation context to wrap
    func wrappedIn(_ navigation: NavigationContext) -> NavigationContext

    #if os(iOS) || os(tvOS)
    /// Wrpas context in specified navigation context
    /// - Parameter navigation: Wrapping navigation context type
    func wrappedIn<T: UINavigationController>(_ navigationClass: T.Type) -> NavigationContext
    #endif

    #if os(iOS) || os(tvOS)
    /// Changes context underlying modal presentation style
    /// - Parameter style: Desired modal presentation style
    func withModalPresentationStyle(_ style: UIModalPresentationStyle) -> NavigationContext
    #endif

    // MARK: - Workflows operations

    /// Presents new workflow modally. It would implicitely call `workflow.start(with: In)` method, and present provided context modally.
    /// - Parameters:
    ///   - workflow: Workflow to present modally
    ///   - input: Workflow input data
    ///   - animated: Animated transition
    ///   - completion: Completion block
    @discardableResult
    func present<W: Workflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool,
        completion: NavigationCompletion?
    ) -> W

    /// Presents new workflow modally. It would implicitely call `workflow.start(with: In)` method, and present provided context modally.
    /// - Parameters:
    ///   - workflow: Workflow to present modally
    ///   - input: Workflow input data
    ///   - animated: Animated transition
    ///   - completion: Completion block
    @discardableResult
    func present<W: AsyncWorkflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool,
        completion: NavigationCompletion?
    ) -> W

    /// Pushes new workflow to the stack. It would implicitely call `workflow.start(with: In)` method, and push provided context onto stack.
    /// - Parameters:
    ///   - workflow: Workflow to push onto stack
    ///   - input: Workflow input data
    ///   - animated: Animated transition
    @discardableResult
    func push<W: Workflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool
    ) -> W

    /// Pushes new workflow to the stack. It would implicitely call `workflow.start(with: In)` method, and push provided context onto stack.
    /// - Parameters:
    ///   - workflow: Workflow to push onto stack
    ///   - input: Workflow input data
    ///   - animated: Animated transition
    @discardableResult
    func push<W: AsyncWorkflow>(
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

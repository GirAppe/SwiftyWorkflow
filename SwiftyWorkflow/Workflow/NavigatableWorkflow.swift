import Foundation

// MARK: - NavigatableWorkflow

/// Convenience implementation - base Workflow class. Subclassing it simplifies adopting `Workflow` protocol.
open class NavigatableWorkflow {

    public weak var context: NavigationContext?
    public weak var parentContext: NavigationContext?

    internal var wrapper: (NavigationContext) -> NavigationContext = { $0 }
    internal var anyEventHandler: Any?

    public init() {}
}

public extension AnyWorkflow where Self: NavigatableWorkflow {

    var onEvent: EventHandler? {
        get { anyEventHandler as? EventHandler }
        set { anyEventHandler = newValue }
    }

    /// Wrap in default navigation context
    func wrapInNavigation() -> Self {
        self.wrapper = { $0.wrappedInNavigation() }
        return self
    }

    /// When workflow is presented, it would be wrapped in specified context (like custom UINavigationController)
    /// - Parameter navigation: Custom navigation context
    func wrapIn(_ navigation: NavigationContext) -> Self {
        self.wrapper = { $0.wrappedIn(navigation) }
        return self
    }
}

// MARK: - Internal

extension NavigationContext {

    /// [Internal] Convenience method to wrap in context if needed
    /// - Parameter workflow: Workflow that defines wrapping context
    func wrapIfNeeded<W: AnyWorkflow>(_ workflow: W) -> NavigationContext {
        guard let workflow = workflow as? NavigatableWorkflow else {
            return self
        }
        return workflow.wrapper(self)
    }
}

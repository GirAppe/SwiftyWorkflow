// MARK: - NavigatableWorkflow

open class NavigatableWorkflow {

    public weak var context: NavigationContext?

    internal var wrapper: (NavigationContext) -> NavigationContext = { $0 }
    internal var anyEventHandler: Any?

    public init() {}
}

public extension Workflow where Self: NavigatableWorkflow {
    var onEvent: EventHandler? {
        get { anyEventHandler as? EventHandler }
        set { anyEventHandler = newValue }
    }

    func wrapInNavigation() -> Self {
        self.wrapper = { $0.wrappedInNavigation() }
        return self
    }

    func wrapIn(_ navigation: NavigationContext) -> Self {
        self.wrapper = { $0.wrappedIn(navigation) }
        return self
    }
}

// MARK: - Internal

extension NavigationContext {

    func wrapIfNeeded<W: Workflow>(_ workflow: W) -> NavigationContext {
        guard let workflow = workflow as? NavigatableWorkflow else {
            return self
        }
        return workflow.wrapper(self)
    }
}

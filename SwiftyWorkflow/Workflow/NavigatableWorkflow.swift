// MARK: - NavigatableWorkflow

open class NavigatableWorkflow {

    public weak var context: NavigationContext?

    internal var wrap: Bool = false
    internal var anyEventHandler: Any?

    public init() {}
}

public extension Workflow where Self: NavigatableWorkflow {
    var onEvent: EventHandler? {
        get { anyEventHandler as? EventHandler }
        set { anyEventHandler = newValue }
    }

    func wrapInNavigation() -> Self {
        self.wrap = true; return self
    }
}

// MARK: - Internal

extension Workflow {
    var wrap: Bool { (self as? NavigatableWorkflow)?.wrap ?? false }
}

extension NavigationContext {
    func wrap(if shouldWrap: Bool) -> NavigationContext {
        shouldWrap ? wrappedInNavigation() : self
    }
}

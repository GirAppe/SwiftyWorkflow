import Foundation

// MARK: - Workflow

/// The easiest way to adopt Workflow protocol is to subclass `NavigatableWorkflow` class, as it already adopts some requirements
public protocol Workflow: class {
    associatedtype In
    associatedtype Event
    typealias EventHandler = (Event, NavigationContext) -> Void

    /// Can contain parent context. It should be filled by parent workflow. In general, when workflow
    /// is presented or pushed onto context, it would be filled automatically.
    var parentContext: NavigationContext? { get set }
    /// Workflow is responsible to fill context when it is started. It should be done in `start(with: In)` method.
    /// In general, it should be done by returning `start(with: NavigationContext)`at the end of `start(with: In)` method.
    var context: NavigationContext? { get set }
    /// Event handler. You can trigger it by calling `perform(_:Event)` method.
    var onEvent: EventHandler? { get set }

    /// Invokes `onEvent` handler clossure with specifed event
    /// - Parameter event: Event
    func perform(_ event: Event)

    /// Would be called when workflow is presented or pushed. Should return a workflow initial context, if the workflow
    /// can start.
    /// > **Plase note:** In this method, either call `start(with: NavigationContext)` or fill `context` property.
    /// - Parameter input: Workflow In parameter
    func start(with input: In) -> NavigationContext?

    /// Convenience method to set `onEvent` handler closure.
    /// > **Please note:**  `onEvent` handler would be overriten
    /// - Parameter onEvent: Event handler closure
    func onEvent(_ onEvent: @escaping EventHandler)
}

// MARK: - Workflow - default event handling

public extension Workflow {

    func perform(_ event: Event) {
        guard let context = context ?? parentContext else { return }
        perform(event, with: context)
    }

    func perform(_ event: Event, with context: NavigationContext) {
        onEvent?(event, context)
    }

    func onEvent(_ onEvent: @escaping EventHandler) {
        self.onEvent = onEvent
    }
}

// MARK: - Workflow - Providing Context

public extension Workflow {

    /// Should always be called during start, otherwise workflow has to manually fill `context` property
    /// - Parameter context: Workflow initial context
    func start(with context: NavigationContext?) -> NavigationContext? {
        self.context = context
        return context
    }

    /// Start with other workflow. No need to any additional calls
    /// - Parameter other: Initial sub-workflow.
    func start<W>(with other: W) -> NavigationContext? where W: Workflow, W.In == Void {
        start(with: other.start())
    }

    /// Start with other workflow. No need to any additional calls
    /// - Parameters:
    ///   - other: Initial sub-workflow
    ///   - input: Initial sub-workflow input
    func start<W>(with other: W, with input: W.In) -> NavigationContext? where W: Workflow {
        start(with: other.start(with: input))
    }
}

public extension Workflow where In == Void {

    /// Convenience, used when workflow has `Void` input type.
    func start() -> NavigationContext? { start(with: ()) }
}

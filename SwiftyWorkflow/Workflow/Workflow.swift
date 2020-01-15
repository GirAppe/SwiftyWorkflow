import UIKit

// MARK: - Workflow

public protocol Workflow: class {
    associatedtype In
    associatedtype Event
    typealias EventHandler = (Event, NavigationContext) -> Void

    var context: NavigationContext? { get set }
    var onEvent: EventHandler? { get set }

    func perform(_ event: Event)

    func start(with input: In) -> NavigationContext

    func onEvent(_ onEvent: @escaping EventHandler)
}

// MARK: - Workflow - default event handling

public extension Workflow {

    func perform(_ event: Event) {
        guard let context = context else { return }
        onEvent?(event, context)
    }

    func onEvent(_ onEvent: @escaping EventHandler) {
        self.onEvent = onEvent
    }
}

// MARK: - Workflow - Providing Context

public extension Workflow {

    func start(with context: NavigationContext) -> NavigationContext {
        self.context = context
        return context
    }

    func start<W>(with other: W) -> NavigationContext where W: Workflow, W.In == Void {
        start(with: other.start())
    }

    func start<W>(with other: W, with input: W.In) -> NavigationContext where W: Workflow {
        start(with: other.start(with: input))
    }
}

public extension Workflow where In == Void {

    func start() -> NavigationContext { start(with: ()) }
}

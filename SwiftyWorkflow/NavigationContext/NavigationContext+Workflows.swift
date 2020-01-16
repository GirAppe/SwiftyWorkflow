import Foundation

public extension NavigationContext {

    /// Presents new workflow modally. It would implicitely call `workflow.start(with: In)` method, and present provided context modally.
    /// - Parameters:
    ///   - workflow: Workflow to present modally
    ///   - animated: Animated transition
    ///   - completion: Completion block
    @discardableResult
    func present<W: Workflow>(
        _ workflow: W,
        animated: Bool = true,
        completion: NavigationCompletion? = nil
    ) -> W where W.In == Void {
        present(
            workflow,
            with: (),
            animated: animated,
            completion: completion
        )
    }

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
        animated: Bool = true,
        completion: NavigationCompletion? = nil
    ) -> W {
        workflow.parentContext = self
        DispatchQueue.main.async {
            guard let context = workflow.start(with: input) else { return }
            self.present(
                context.wrapIfNeeded(workflow),
                animated: animated,
                completion: completion
            )
        }
        return workflow
    }

    /// Pushes new workflow to the stack. It would implicitely call `workflow.start(with: In)` method, and push provided context onto stack.
    /// - Parameters:
    ///   - workflow: Workflow to push onto stack
    ///   - animated: Animated transition
    @discardableResult
    func push<W: Workflow>(
        _ workflow: W,
        animated: Bool = true
    ) -> W where W.In == Void {
        push(workflow, with: (), animated: animated)
    }

    /// Pushes new workflow to the stack. It would implicitely call `workflow.start(with: In)` method, and push provided context onto stack.
    /// - Parameters:
    ///   - workflow: Workflow to push onto stack
    ///   - input: Workflow input data
    ///   - animated: Animated transition
    @discardableResult
    func push<W: Workflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool = true
    ) -> W {
        workflow.parentContext = self
        DispatchQueue.main.async {
            guard let context = workflow.start(with: input) else { return }
            self.push(context, animated: animated)
        }
        return workflow
    }
}

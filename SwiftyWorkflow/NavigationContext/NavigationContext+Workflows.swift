import Foundation

// MARK: - Synchronous Workflows

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
            self.present(
                workflow.start(with: input).wrapIfNeeded(workflow),
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
            self.push(workflow.start(with: input), animated: animated)
        }
        return workflow
    }
}

// MARK: - Asynchronous Workflow

public extension NavigationContext {

    /// Presents new workflow modally. It would implicitely call `workflow.start(with: In)` method, and present provided context modally.
    /// - Parameters:
    ///   - workflow: Workflow to present modally
    ///   - animated: Animated transition
    ///   - completion: Completion block
    @discardableResult
    func present<W: AsyncWorkflow>(
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
    func present<W: AsyncWorkflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool = true,
        completion: NavigationCompletion? = nil
    ) -> W {
        workflow.parentContext = self
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            workflow.start(with: input, in: self) { [weak self] context in
                self?.present(
                    context.wrapIfNeeded(workflow),
                    animated: animated,
                    completion: completion
                )
            }
        }
        return workflow
    }

    /// Pushes new workflow to the stack. It would implicitely call `workflow.start(with: In)` method, and push provided context onto stack.
    /// - Parameters:
    ///   - workflow: Workflow to push onto stack
    ///   - animated: Animated transition
    @discardableResult
    func push<W: AsyncWorkflow>(
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
    func push<W: AsyncWorkflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool = true
    ) -> W {
        workflow.parentContext = self
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            workflow.start(with: input, in: self) { [weak self] context in
                self?.push(context, animated: animated)
            }
        }
        return workflow
    }
}

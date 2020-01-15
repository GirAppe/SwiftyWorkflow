public extension NavigationContext {

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

    @discardableResult
    func present<W: Workflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool = true,
        completion: NavigationCompletion? = nil
    ) -> W {
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

    @discardableResult
    func push<W: Workflow>(
        _ workflow: W,
        animated: Bool = true
    ) -> W where W.In == Void {
        push(workflow, with: (), animated: animated)
    }

    @discardableResult
    func push<W: Workflow>(
        _ workflow: W,
        with input: W.In,
        animated: Bool = true
    ) -> W {
        DispatchQueue.main.async {
            guard let context = workflow.start(with: input) else { return }
            self.push(context, animated: animated)
        }
        return workflow
    }
}

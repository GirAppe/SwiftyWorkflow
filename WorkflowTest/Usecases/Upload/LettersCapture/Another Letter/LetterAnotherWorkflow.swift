import SwiftyWorkflow

class LetterAnotherWorkflow: NavigatableWorkflow, Workflow {
    typealias In = Void
    enum Event {
        case next
        case another
        case cancel
    }

    func start(with input: Void) -> NavigationContext? {
        let view = Factory.instance.anotherLetterView()
        view.workflow = self
        return start(with: view)
    }

    // MARK: - Actions

    func next()  {
        perform(.next)
    }

    func captureAnotherLetter() {
        perform(.another)
    }

    func cancel() {
        perform(.cancel)
    }
}

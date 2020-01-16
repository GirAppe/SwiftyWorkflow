import SwiftyWorkflow

class SelfieCaptureWorkflow: NavigatableWorkflow, Workflow {
    typealias In = SelfieCaptureRequirements
    enum Event {
        case captured([ImageData])
        case cancel
    }

    var requirements: SelfieCaptureRequirements!

    func start(with input: SelfieCaptureRequirements) -> NavigationContext {
        requirements = input

        let view = Factory.instance.selfieCaptureView()
        view.workflow = self
        return start(with: view)
    }

    // MARK: - Actions

    func captured(_ selfies: [ImageData]) {
        perform(.captured(selfies))
    }

    func cancel() {
        perform(.cancel)
    }
}

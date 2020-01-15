import SwiftyWorkflow

extension CapturedSelfie: ImagesReviewContext {
    var title: String {
        "\(type)"
    }
}

class SelfieReviewWorkflow: NavigatableWorkflow, Workflow {
    typealias In = CapturedSelfie
    enum Event {
        case confirmed(CapturedSelfie)
        case retake
        case cancel
    }

    var capturedSelfie: CapturedSelfie!

    func start(with input: CapturedSelfie) -> NavigationContext? {
        capturedSelfie = input

        let view = Factory.instance.selfieReviewView()
        view.workflow = self
        return start(with: view)
    }
}

extension SelfieReviewWorkflow: ImagesReviewWorkflow {
    var reviewContext: ImagesReviewContext { capturedSelfie }

    func confirm() {
        perform(.confirmed(capturedSelfie))
    }

    func retake() {
        perform(.retake)
    }

    func cancel() {
        perform(.cancel)
    }
}

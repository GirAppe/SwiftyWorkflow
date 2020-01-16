import SwiftyWorkflow

class EvidenceReviewWorkflow: NavigatableWorkflow, Workflow, ImagesReviewWorkflow {
    typealias In = CapturedEvidence
    enum Event {
        case confirmed(CapturedEvidence)
        case retake
        case cancel
    }

    private var evidence: CapturedEvidence!
    var reviewContext: ImagesReviewContext { evidence }

    func start(with input: CapturedEvidence) -> NavigationContext {
        self.evidence = input

        let view = Factory.instance.evidenceReviewView()
        view.workflow = self
        return start(with: view)
    }

    func confirm() {
        perform(.confirmed(evidence))
    }

    func retake() {
        perform(.retake)
    }

    func cancel() {
        perform(.cancel)
    }
}

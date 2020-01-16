import SwiftyWorkflow

struct UploadEnvelope {
    let evidence: CapturedEvidence
    var letters: CapturedLetters?
    var selfie: CapturedSelfie?
}

class UploadEnvelopeWorkflow: NavigatableWorkflow, Workflow {
    typealias In = UploadEnvelope
    enum Event {
        case success
        case cancel
        case failure
    }

    var envelope: UploadEnvelope!

    func start(with input: UploadEnvelope) -> NavigationContext? {
        self.envelope = input

        let view = Factory.instance.uploadView()
        view.workflow = self
        return start(with: view)
    }

    // MARK: - Action

    func success() {
        perform(.success)
    }

    func failed() {
        perform(.failure)
    }

    func cancel() {
        perform(.cancel)
    }
}

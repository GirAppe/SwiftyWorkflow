import SwiftyWorkflow

enum EvidenceSide {
    case front
    case back
}

struct EvidenceCaptureContext: ImageCaptureContext {
    let type: EvidenceType
    let side: EvidenceSide

    var title: String {
        switch (type, side) {
        case (.passport, _):
            return "Scan your passport"
        case (.id, .front):
            return "Scan the front of your id"
        case (.id, .back):
            return "Scan the back of your id"
        case (.drivingLicence, .front):
            return "Scan the front of your driving licence"
        case (.drivingLicence, .back):
            return "Scan the back of your driving licence"
        }
    }
}

class EvidencePhotoCaptureWorkflow: NavigatableWorkflow, Workflow, ImageCaptureWorkflow {

    typealias In = EvidenceCaptureContext
    enum Event {
        case cancel
        case captured(ImageData,EvidenceCaptureContext)
    }

    private var evidenceCaptureContext: EvidenceCaptureContext!
    var captureContext: ImageCaptureContext { evidenceCaptureContext }

    func start(with input: EvidenceCaptureContext) -> NavigationContext? {
        evidenceCaptureContext = input

        let view = Factory.instance.evidenceCaptureView()
        view.workflow = self
        return start(with: view)
    }


    func captured(_ image: ImageData) {
        perform(.captured(image, evidenceCaptureContext))
    }

    func cancel() {
        perform(.cancel)
    }
}

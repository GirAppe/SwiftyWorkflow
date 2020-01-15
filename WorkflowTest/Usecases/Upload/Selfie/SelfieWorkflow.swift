import SwiftyWorkflow

enum SelfieCaptureRequirements {
    case manual
    case automatic
    case biometric
}

struct CapturedSelfie {
    let type: SelfieCaptureRequirements
    let images: [ImageData]
}

class SelfieWorkflow: NavigatableWorkflow, Workflow {
    typealias In = SelfieCaptureRequirements
    enum Event {
        case captured(CapturedSelfie)
        case cancel
    }

    private var requirements: SelfieCaptureRequirements!

    func start(with input: SelfieCaptureRequirements) -> NavigationContext? {
        requirements = input

        let capture = SelfieCaptureWorkflow()
        let review = SelfieReviewWorkflow()

        capture.onEvent { event, context in
            switch event{
            case .captured(let selfies):
                let capturedSelfie = CapturedSelfie(
                    type: self.requirements,
                    images: selfies
                )
                context.push(review, with: capturedSelfie)
            case .cancel:
                self.perform(.cancel)
            }
        }

        review.onEvent { event, context in
            switch event {
            case .confirmed(let selfie):
                self.perform(.captured(selfie))
            case .retake:
                context.pop(animated: true)
            case .cancel:
                self.perform(.cancel)
            }
        }

        return start(with: capture, with: requirements)
    }
}

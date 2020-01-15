import SwiftyWorkflow

struct CapturedEvidence: ImagesReviewContext {
    let type: EvidenceType
    let images: [ImageData]
    var title: String { "\(type)" }
}

class EvidenceCaptureWorkflow: NavigatableWorkflow, Workflow {
    typealias In = EvidenceType
    enum Event {
        case captured(CapturedEvidence)
        case cancel
    }

    private var evidenceType: EvidenceType!
    private var capturedImages: [ImageData] = []
    private var capturedEvidence: CapturedEvidence {
        CapturedEvidence(type: evidenceType, images: capturedImages)
    }

    func start(with input: EvidenceType) -> NavigationContext? {
        evidenceType = input
        capturedImages = []

        return self.start(with: build())
    }

    func build() -> NavigationContext? {
        // Front
        let captureFront = EvidencePhotoCaptureWorkflow()
        let frontContext = EvidenceCaptureContext(
            type: evidenceType,
            side: .front
        )

        // Back
        let captureBack = EvidencePhotoCaptureWorkflow()
        let backContext = EvidenceCaptureContext(
            type: evidenceType,
            side: .back
        )

        captureFront.onEvent { event, context in
            switch event {
            case let .captured(image, capture):
                self.captured(image, at: capture.side)
                context.push(captureBack, with: backContext)
            case .cancel:
                self.cancel()
            }
        }

        // Review and number of pages
        if evidenceType == .passport {
            buildReview(after: captureFront)
        } else {
            buildReview(after: captureBack)
        }

        return start(with: captureFront, with: frontContext)
    }

    private func buildReview(after workflow: EvidencePhotoCaptureWorkflow) {
        let review = EvidenceReviewWorkflow()

        review.onEvent { event, context in
            switch event {
            case .confirmed(let evidence):
                self.perform(.captured(evidence))
            case .retake:
                self.retake(context)
            case .cancel:
                self.cancel()
            }
        }

        workflow.onEvent { event, context in
            switch event {
            case let .captured(image, capture):
                self.captured(image, at: capture.side)
                context.push(review, with: self.capturedEvidence)
            case .cancel:
                self.cancel()
            }
        }
    }

    // MARK: - Actions

    func captured(_ image: ImageData, at side: EvidenceSide) {
        switch side {
        case .front:
            capturedImages = [image]
        case .back:
            capturedImages = [capturedImages.first!, image]
        }
    }

    func retake(_ context: NavigationContext) {
        guard let start = self.context else { return }
        context.pop(to: start, animated: true)
    }

    func cancel() {
        perform(.cancel)
    }
}

extension Array {
    func keepFirst(_ n: Int) -> Self {
        self
    }
}

import UIKit
import SwiftyWorkflow

// MARK: - UploadWorkflow

class UploadWorkflow: NavigatableWorkflow, Workflow {
    typealias In = UploadPayload
    enum Event {
        case success
        case cancel
        case failure(reason: String)
    }

    // MARK: - Properties

    private var payload: UploadPayload!
    private var capturedEvidence: CapturedEvidence?
    private var capturedLetters: CapturedLetters?
    private var capturedSelfie: CapturedSelfie?

    // MARK: - Lifecycle

    func start(with input: UploadPayload) -> NavigationContext {
        self.payload = input

        if !payload.letter {
            return startFromEvidence()
        } else {
            return startFromCaptureLetter()
        }
    }

    // MARK: - Actions

    func startFromEvidence() -> NavigationContext {
        return start(with: buildEvidenceCapture(), with: payload.evidences)
    }

    func startFromCaptureLetter() -> NavigationContext {
        return start(with: buildLetterCapture(), with: payload.letterRequirements!)
    }

    @discardableResult
    func resolveNextStep(_ context: NavigationContext) -> Any {
        print("Resolving next step")

        // Evidence capture
        if capturedEvidence == nil {
            return context.push(buildEvidenceCapture(), with: payload.evidences)
        }

        // Selfies
        if let type = payload.selfieType, capturedSelfie == nil {
            return context.push(buildSelfieCapture(), with: type)
        }

        // Upload
        if let envelope = buildEnvelope() {
            return context.push(buildUpload(), with: envelope)
        }

        print("cant resolve next step,since its not implemented")
        return ()
    }

    // MARK: - Builders

    func buildEvidenceCapture() -> EvidenceSelectionWorkflow {
        let selection = EvidenceSelectionWorkflow()
        let capture = EvidenceCaptureWorkflow()

        selection.onEvent { event, context in
            switch event {
            case .selected(let type):
                context.push(capture, with: type)
            case .cancel:
                self.cancelIfNeeded(context)
            }
        }

        capture.onEvent { event, context in
            switch event {
            case .captured(let evidence):
                self.capturedEvidence = evidence
                self.capturedSelfie = nil
                self.resolveNextStep(context)
            case .cancel:
                self.cancelIfNeeded(context)
            }
        }

        return selection
    }

    func buildLetterCapture() -> LetterCaptureWorkflow {
        let capture = LetterCaptureWorkflow()

        capture.onEvent { event, context in
            switch event {
            case .captured(let letters):
                self.capturedLetters = letters
                print("CAPTURED \(letters.count) LETTERS!")
                self.resolveNextStep(context)
            case .cancel:
                self.cancelIfNeeded(context)
            }
        }

        return capture
    }

    func buildSelfieCapture() -> SelfieWorkflow {
        let selfie = SelfieWorkflow()

        selfie.onEvent { event, context in
            switch event {
            case .captured(let selfie):
                self.capturedSelfie = selfie
                self.resolveNextStep(context)
            case .cancel:
                self.cancelIfNeeded(context)
            }
        }

        return selfie
    }

    func buildUpload() -> UploadEnvelopeWorkflow  {
        let upload = UploadEnvelopeWorkflow()

        upload.onEvent { event, context in
            switch event {
            case .success:
                self.perform(.success)
            case .cancel:
                self.cancelIfNeeded(context)
            case .failure:
                self.perform(.failure(reason: "Upload failed!"))
            }
        }

        return upload
    }

    // MARK: - Helpers

    func buildEnvelope() -> UploadEnvelope? {
        guard let evidence = capturedEvidence else { return nil }

        return UploadEnvelope(
            evidence: evidence,
            letters: capturedLetters,
            selfie: capturedSelfie
        )
    }

    func cancelIfNeeded(_ context: NavigationContext) {
        let cancel: VoidCallback = { [weak self] in self?.perform(.cancel) }

        context.present(Dialog(
            title: "Cancel?",
            message: "Do you really want to cancel upload?",
            actions: [
                .init(title: "Yes", style: .destructive, onTap: cancel),
                .init(title: "No", style: .secondary)
            ]
        ))
    }
}

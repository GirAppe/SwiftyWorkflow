import SwiftyWorkflow

typealias CapturedLetters = [CapturedLetter]

struct CapturedLetter {
    let id: String
    var pages: [ImageData] = []
    var numberOfPages: Int { pages.count }
}

struct LetterCapture {
    let id: String
    let pages: [LetterPageCapture]
}

class LetterCaptureWorkflow: NavigatableWorkflow, Workflow {
    typealias In = LetterCapture
    enum Event {
        case captured(CapturedLetters)
        case cancel
    }

    var capture: LetterCapture!
    var capturedImages: [ImageData?] = []
    var letter: CapturedLetter?

    func start(with input: LetterCapture) -> NavigationContext {
        capture = input
        letter = nil
        capturedImages = Array(repeating: nil, count: input.pages.count + 2)

        return start(with: buildNewLetterCapture())
    }

    func buildNewLetterCapture() -> LetterPageCaptureWorkflow {
        let captures = capture.pages.map(LetterPageCaptureWorkflow.init)
        let review = LetterReviewWorkflow()
        let another = LetterAnotherWorkflow()
        let first = captures.first!
        let last = captures.last!

        captures.forEachPair { currentPage, nextPage in
            currentPage.onEvent { event, context in
                switch event {
                case let .captured(image, at: index):
                    self.captured(image, at: index)
                    context.push(nextPage)
                case .cancel:
                    self.perform(.cancel)
                }
            }
        }

        last.onEvent { event, context in
            switch event {
            case let .captured(image, at: index):
                self.captured(image, at: index)
                context.push(review, with: self.createLetter())
            case .cancel:
                self.perform(.cancel)
            }
        }

        review.onEvent { event, context in
            switch event {
            case .confirmed(let letter):
                self.letter = letter
                context.push(another)
            case .retake:
                self.retake(context)
            case .cancel:
                self.cancel()
            }
        }

        another.onEvent { event, context in
            switch event {
            case .next:
                self.finished()
            case .another:
                self.captureAnotherLetter(in: context)
            case .cancel:
                self.cancel()
            }
        }

        return first
    }

    // MARK: - Actions

    func captured(_ image: ImageData, at index: Int) {
        capturedImages[index] = image
    }

    func finished() {
        guard let letter = letter else { return }
        perform(.captured([letter]))
    }

    func finished(additional letters: CapturedLetters) {
        guard let letter = letter else { return }
        perform(.captured([letter] + letters))
    }

    func createLetter() -> CapturedLetter {
        CapturedLetter(
            id: capture.id,
            pages: capturedImages.compactMap { $0 }
        )
    }

    func captureAnotherLetter(in mainContext: NavigationContext) {
        mainContext.present(QRScanWorkflow()).onEvent { event, context in
            context.dismiss(animated: true) {
                guard case let .success(qrPayload) = event else {
                    return self.scanFailed(with: mainContext)
                }
                guard case let .upload(payload) = qrPayload else {
                    return self.scanFailed(with: mainContext)
                }
                guard let requirements = payload.letterRequirements else {
                    return self.scanFailed(with: mainContext)
                }

                mainContext.push(LetterCaptureWorkflow(), with: requirements).onEvent { event, context in
                    switch event {
                    case .captured(let letters):
                        self.finished(additional: letters)
                    case .cancel:
                        self.cancel()
                    }
                }
            }
        }
    }

    func scanFailed(with context: NavigationContext) {
        context.present(Dialog(
            title: "QR Failure",
            message: "Not recognized qr code",
            actions: [.init(title: "OK", style: .secondary)]
        ))
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
    func forEachPair(_ body: (Element, Element) -> Void) {
        guard count >= 2 else { return }
        for index in 1..<count {
            let first = self[index - 1]
            let second = self[index]
            body(first,second)
        }
    }
}

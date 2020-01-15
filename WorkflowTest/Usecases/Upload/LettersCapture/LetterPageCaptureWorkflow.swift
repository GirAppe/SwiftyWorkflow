import SwiftyWorkflow

struct LetterPageCapture: ImageCaptureContext {
    let page: Int
    let pages: Int
    var title: String { "Letter (page \(page) of \(pages))" }
}

class LetterPageCaptureWorkflow: NavigatableWorkflow, Workflow {
    typealias In = Void
    enum Event {
        case captured(ImageData, at: Int)
        case cancel
    }

    let pageCapture: LetterPageCapture

    init(pageCapture: LetterPageCapture) {
        self.pageCapture = pageCapture
    }

    func start(with input: Void) -> NavigationContext? {
        let view = Factory.instance.letterCaptureView()
        view.workflow = self
        return start(with: view)
    }
}

extension LetterPageCaptureWorkflow: ImageCaptureWorkflow {

    var captureContext: ImageCaptureContext { pageCapture }

    func captured(_ image: ImageData) {
        perform(.captured(image, at: pageCapture.page))
    }

    func cancel() {
        perform(.cancel)
    }
}

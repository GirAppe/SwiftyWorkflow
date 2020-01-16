import SwiftyWorkflow

extension CapturedLetter: ImagesReviewContext {
    var images: [ImageData] { pages }
    var title: String { "Letter (\(numberOfPages)p)" }
}

class LetterReviewWorkflow: NavigatableWorkflow, Workflow {
    typealias In = CapturedLetter
    enum Event {
        case confirmed(CapturedLetter)
        case retake
        case cancel
    }

    private var letter: CapturedLetter!

    func start(with input: CapturedLetter) -> NavigationContext {
        letter = input

        let view = Factory.instance.letterReviewView()
        view.workflow = self
        return start(with: view)
    }
}

extension LetterReviewWorkflow: ImagesReviewWorkflow {
    
    var reviewContext: ImagesReviewContext { letter }

    func confirm() {
        perform(.confirmed(letter))
    }

    func retake() {
        perform(.retake)
    }

    func cancel() {
        perform(.cancel)
    }
}

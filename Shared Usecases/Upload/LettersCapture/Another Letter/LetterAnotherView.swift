import UIKit
import SwiftyWorkflow

protocol LetterAnotherView: NavigationContext, AutoMockable {
    var workflow: LetterAnotherWorkflow! { get set }
}

class LetterAnotherViewController: UIViewController, LetterAnotherView {

    var workflow: LetterAnotherWorkflow!

    // MARK: - Actions

    @IBAction func cancel() {
        workflow.cancel()
    }

    @IBAction func captureAnother() {
        workflow.captureAnotherLetter()
    }

    @IBAction func next() {
        workflow.next()
    }
}

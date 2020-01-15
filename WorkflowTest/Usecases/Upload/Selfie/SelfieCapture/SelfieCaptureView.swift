import UIKit
import SwiftyWorkflow

protocol SelfieCaptureView: NavigationContext, AutoMockable {
    var workflow: SelfieCaptureWorkflow! { get set }
}

class SelfieCaptureViewController: UIViewController, SelfieCaptureView {

    var workflow: SelfieCaptureWorkflow!

    // MARK: - Outlets

    @IBOutlet weak var infoLabel: UILabel!

    // MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // That sould come from View Model
        infoLabel.text = "Capture \(workflow.requirements!) selfie"
    }

    // MARK: - Actions

    @IBAction func cancel() {
        workflow.cancel()
    }

    @IBAction func capture() {
        let data = Array(repeating: ImageData(), count: 3)
        workflow.captured(data)
    }
}

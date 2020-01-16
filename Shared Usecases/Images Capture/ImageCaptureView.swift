import UIKit
import SwiftyWorkflow

protocol ImageCaptureView: NavigationContext, AutoMockable {
    var workflow: ImageCaptureWorkflow! { get set }
}

class ImageCaptureViewController: UIViewController, ImageCaptureView {

    var workflow: ImageCaptureWorkflow!

    // MARK: - Outlets

    @IBOutlet weak var infoLabel: UILabel!

    // MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // That sould come from View Model
        setup(with: workflow.captureContext)
    }

    func setup(with context: ImageCaptureContext) {
        infoLabel.text = context.title
    }

    // MARK: - Actions

    @IBAction func cancel() {
        workflow.cancel()
    }

    @IBAction func capture() {
        workflow.captured(ImageData())
    }
}

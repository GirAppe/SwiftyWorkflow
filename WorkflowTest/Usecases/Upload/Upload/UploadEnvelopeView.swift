import UIKit
import SwiftyWorkflow

protocol UploadEnvelopeView: NavigationContext, AutoMockable {
    var workflow: UploadEnvelopeWorkflow! { get set }
}

class UploadEnvelopeViewController: UIViewController, UploadEnvelopeView {

    var workflow: UploadEnvelopeWorkflow!

    // MARK: - Outlets

    @IBOutlet weak var infoLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let envelope = workflow.envelope!

        infoLabel.text = """
        Uploading...

        Evidences:
            \(envelope.evidence.type) - \(envelope.evidence.images.count) images
        Letters:
            \(envelope.letters?.count ?? 0) letters
        Selfie:
            \(selfieInfo())
        """
    }

    private func selfieInfo() -> String {
        guard let selfie = workflow.envelope.selfie else { return "none" }
        return "\(selfie.type) - \(selfie.images.count) images"
    }

    // MARK: - Actions

    @IBAction func success() {
        workflow.success()
    }

    @IBAction func failed() {
        workflow.failed()
    }

    @IBAction func cancel() {
        workflow.cancel()
    }
}

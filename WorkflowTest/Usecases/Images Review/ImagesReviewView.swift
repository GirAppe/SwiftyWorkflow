import UIKit
import SwiftyWorkflow

protocol ImagesReviewView: NavigationContext, AutoMockable {
    var workflow: ImagesReviewWorkflow! { get set }
}

class ImagesReviewViewController: UIViewController, ImagesReviewView {

    var workflow: ImagesReviewWorkflow!

    // MARK: - Outlets

    @IBOutlet weak var infoLabel: UILabel!

    // MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // That sould come from View Model
        setup(with: workflow.reviewContext)
    }

    func setup(with context: ImagesReviewContext) {
        infoLabel.text = """
        title: \(context.title)

        number of images: \(context.images.count)

        images:

        \(context.images.map({ "  - \($0.id)" }).joined(separator: "\n"))
        """
    }

    // MARK: - Actions

    @IBAction func cancel() {
        workflow.cancel()
    }

    @IBAction func retake() {
        workflow.retake()
    }

    @IBAction func confirm() {
        workflow.confirm()
    }
}

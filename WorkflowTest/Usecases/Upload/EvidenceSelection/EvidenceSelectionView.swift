import UIKit
import SwiftyWorkflow

protocol EvidenceSelectionView: NavigationContext, AutoMockable {
    var workflow: EvidenceSelectionWorkflow! { get set }
}

class EvidenceSelectionViewController: UIViewController, EvidenceSelectionView {

    var workflow: EvidenceSelectionWorkflow!

    // MARK: - Outlets

    @IBOutlet weak var passportButton: UIButton!
    @IBOutlet weak var drivingLicenceButton: UIButton!
    @IBOutlet weak var idCardButton: UIButton!

    // MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()

        // That sould come from View Model
        setup(with: workflow.allowedEvidenceTypes)
    }

    func setup(with allowed: AllowedEvidenceTypes) {
        passportButton.isHidden = !allowed.contains(.passport)
        drivingLicenceButton.isHidden = !allowed.contains(.drivingLicence)
        idCardButton.isHidden = !allowed.contains(.id)
    }

    // MARK: - Actions

    @IBAction func cancel() {
        workflow.perform(.cancel)
    }

    @IBAction func didSelectPassport() {
        workflow.perform(.selected(.passport))
    }

    @IBAction func didSelectDrivinglicence() {
        workflow.perform(.selected(.drivingLicence))
    }

    @IBAction func didSelectIdCard() {
        workflow.perform(.selected(.id))
    }
}

import UIKit
import SwiftyWorkflow

protocol QRScanView: NavigationContext {
    var workflow: QRScanWorkflow! { get set }
}

class QRScanViewController: UIViewController, QRScanView {

    var workflow: QRScanWorkflow!

    // MARK: - Actions

    @IBAction func startWithEvidenceSelectionAll() {
        didScan(UploadPayload(
            evidences: EvidenceType.allCases,
            selfieType: .manual,
            geolocation: false,
            notify: false
        ))
    }

    @IBAction func startWithEvidenceSelectionPassportAndId() {
        didScan(UploadPayload(
            evidences: [.id, .passport],
            geolocation: false,
            notify: false
        ))
    }

    @IBAction func startWithLetter() {
        didScan(UploadPayload(
            evidences: [.id, .passport],
            numberOfPages: Int.random(in: 1...3),
            selfieType: .automatic,
            geolocation: true,
            notify: true
        ))
    }

    @IBAction func didscanOtherPayload() {
        didScan("https://google.com")
    }

    @IBAction func cancel() {
        workflow.perform(.cancel)
    }

    // MARK: - Helpers

    private func didScan(_ payload: UploadPayload) {
        workflow.perform(.success(.upload(payload)))
    }

    private func didScan(_ payload: String) {
        workflow.perform(.success(.other(payload)))
    }
}

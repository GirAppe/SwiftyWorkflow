import UIKit

class ViewController: UIViewController {

    let workflow = MainWorkflow()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Temporary, just for test app
        _ = workflow.start(with: self)
        _ = workflow.start(with: ())
    }

    @IBAction func launchQRScanner() {
        workflow.startQrScan(from: self)
    }
}

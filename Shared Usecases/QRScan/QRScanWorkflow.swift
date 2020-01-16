import SwiftyWorkflow

class QRScanWorkflow: NavigatableWorkflow, Workflow {
    typealias In = Void
    enum Event {
        case success(QRCodePayload)
        case failure
        case cancel
    }

    func start(with input: Void) -> NavigationContext? {
        let view = Factory.instance.qrScanView()
        view.workflow = self
        return start(with: view)
    }
}

import Foundation
import UIKit.UIImage

// MARK: - Tests
class ScanDocumentsStep: FlowConnector {
    typealias In = Void
    struct Out {
        static var confirm = Transition<UIImage>()
        static var deny = Transition<Void>()
        static var cancel = Transition<Void>()
    }

    weak var view: ViewType!
    weak var flowNavigation: NavigationProvider!

    init() {}

    func userDidApproved() {
        perform(Out.confirm, with: UIImage())
    }

    func userDidDenied() {
        perform(Out.deny)
    }
}
class VerifyImageStep: FlowConnector {
    typealias In = UIImage
    struct Out {
        static var ok = Transition<Void>()
        static var cancel = Transition<Void>()
    }

    weak var view: ViewType!
    weak var flowNavigation: NavigationProvider!

    init(_ input: In) {
    }
}

// MARK: - UploadWorkflow
class UploadWorkflow: Workflow, FlowConnector {
    enum In {
        case passport
        case id
    }
    struct Out {
        static let success = Transition<Void>()
        static let error = Transition<Error>()
    }

    weak var view: ViewType!
    weak var flowNavigation: NavigationProvider!

    override init() {
        super.init()


    }

    func build() {
        let node = registerFlow(ScanDocumentsStep.self) { (container, input) -> ScanDocumentsStep in
            return ScanDocumentsStep()
        }

        let upload = registerFlow(UploadWorkflow.self) { (container, input: UploadWorkflow.In) -> UploadWorkflow in
            switch input {
            case UploadWorkflow.In.passport:
                return UploadWorkflow()
            case UploadWorkflow.In.id:
                return UploadWorkflow()
            }
        }

        node.bridge(to: upload, for: ScanDocumentsStep.Out.confirm, bridge: { _ in .id }, connector: { (scan, upload) in
            scan.view?.present(upload.view, animated: true)
        })



    }
}

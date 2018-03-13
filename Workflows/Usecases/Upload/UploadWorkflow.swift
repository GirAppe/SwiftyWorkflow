import UIKit.UIImage
import Foundation
import SwiftyWorkflow

class UploadWorkflow: Workflow, Navigatable {
    typealias In = Void
    class Out: FlowTransition {
        static var cancel = Out(Void.self)
        static var success = Out(Void.self)

        init<T>(_ type: T.Type) { super.init(type) }
    }

    override weak var view: ViewType! {
        get { return super.view ?? self.start() }
        set { super.view = newValue }
    }

    init(resolver: Resolver) {
        super.init()
    }

    override func build() {
        let scanQR = add(ScanQRFlow.self, factory: ScanQRFlow.init)
        let scanDocument = add(ScanDocumentFlow.self, input: DocumentType.self, factory: ScanDocumentFlow.init)
        let verify = add(VerifyImageFlow.self, input: UIImage.self, factory: VerifyImageFlow.init)

        starts(with: scanQR)

        scanQR.on(.success, push: scanDocument, animated: true)
        scanDocument.on(.success, push: verify, animated: true)
        verify.on(.tryAgain, unwind: scanDocument) { source, destination in
            source.view.pop(animated: true)
        }
        verify.on(.success, end: self, with: .success)

        scanQR.on(.cancel, end: self, with: .cancel)
        scanDocument.on(.cancel, end: self, with: .cancel)
        verify.on(.cancel, end: self, with: .cancel)
    }

    var lastLetter: WorkflowNode<ScanDocumentFlow>!

    func addAnotherLetter() {
        let newLetter = self.add(ScanDocumentFlow.self, input: DocumentType.self, factory: ScanDocumentFlow.init)
        newLetter.on(.cancel, end: self, with: .cancel)
        lastLetter.on(.oneMore, push: newLetter, animated: true)
        lastLetter = newLetter

    }
}

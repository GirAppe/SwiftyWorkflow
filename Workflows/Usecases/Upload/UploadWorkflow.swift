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

        scanQR.on(.ok, push: scanDocument, animated: true)
        scanDocument.on(.ok, push: verify, animated: true)
        verify.on(.tryAgain, unwind: scanDocument) { source, destination in
            source.view.pop(animated: true)
        }
        verify.on(.ok, end: self, with: .success)

        scanQR.on(.cancel, end: self, with: .cancel)
        scanDocument.on(.cancel, end: self, with: .cancel)
        verify.on(.cancel, end: self, with: .cancel)

//        let scanQR = add(ScanQRFlow.self) { r in
//            return ScanQRFlow(resolver: r)
//        }
//
//        let scanDocument = add(ScanDocumentFlow.self, input: DocumentType.self) { r, type in
//            return ScanDocumentFlow(resolver: r, type: type)
//        }
//
//        let verifyDocument = add(VerifyImageFlow.self, input: UIImage.self) { r, image in
//            return VerifyImageFlow(resolver: r, image: image)
//        }
//
//        // Flow connections
//        scanQR.connect(to: scanDocument, for: ScanQRFlow.Out.ok) { scanQR, scanDoc in
//            scanQR.view.push(scanDoc.view, animated: true)
//        }
//
//        scanDocument.connect(to: verifyDocument, for: ScanDocumentFlow.Out.ok) { scan, verify in
//            verify.type = scan.type // should be done by passing more than it
//            scan.view.push(verify.view, animated: true)
//        }
//
//        verifyDocument.connectTo(scanDocument, for: .tryAgain) { verify, scan in
//            verify.view.pop(to: scan.view, animated: true)
//        }
//
//        // Flow starting point
//        self.setEntry(scanQR)
//
//        // Flow end
////        verifyDocument.end(flow: self)
//
//        // Cancellation
//        scanQR.cancel(flow: self)
//        scanDocument.cancel(flow: self)
//        verifyDocument.cancel(flow: self)
    }
}

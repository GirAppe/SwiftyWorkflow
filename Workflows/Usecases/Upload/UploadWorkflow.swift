import UIKit.UIImage
import Foundation
import SwiftyWorkflow

class UploadWorkflow: Workflow, Navigatable {
    typealias In = Void
    typealias Out = Void

    override func build() {
        let scanQR = addNode(ScanQRFlow.self) { r in
            return ScanQRFlow(resolver: r)
        }

        let scanDocument = addNode(ScanDocumentFlow.self, input: DocumentType.self) { r, type in
            return ScanDocumentFlow(resolver: r, type: type)
        }

        let verifyDocument = addNode(VerifyImageFlow.self, input: UIImage.self) { r, image in
            return VerifyImageFlow(resolver: r, image: image)
        }

        // Flow connections
        scanQR.connect(to: scanDocument, for: ScanQRFlow.Out.ok) { scanQR, scanDoc in
            scanQR.view.push(scanDoc.view, animated: true)
        }

        scanDocument.connect(to: verifyDocument, for: ScanDocumentFlow.Out.ok) { scan, verify in
            verify.type = scan.type // should be done by passing more than it
            scan.view.push(verify.view, animated: true)
        }

        verifyDocument.connect(to: scanDocument, for: VerifyImageFlow.Out.tryAgain) { verify, scan in
            verify.view.pop(to: scan.view, animated: true)
        }

        // Flow starting point
        self.setEntry(scanQR)

        // Flow end
        verifyDocument.end(flow: self)

        // Cancellation
        scanQR.cancel(flow: self)
        scanDocument.cancel(flow: self)
        verifyDocument.cancel(flow: self)
    }
}

import UIKit

protocol ViewsFactory: AutoMockable {

    func qrScanView() -> QRScanView

    func letterCaptureView() -> ImageCaptureView
    func letterReviewView() -> ImagesReviewView
    func anotherLetterView() -> LetterAnotherView

    func evidenceSelectionView() -> EvidenceSelectionView
    func evidenceCaptureView() -> ImageCaptureView
    func evidenceReviewView() -> ImagesReviewView

    func selfieCaptureView() -> SelfieCaptureView
    func selfieReviewView() -> ImagesReviewView

    func uploadView() -> UploadEnvelopeView
}

class Factory: ViewsFactory {

    static var instance: ViewsFactory = Factory()

    func qrScanView() -> QRScanView {
        QRScanViewController.loadFromStoryboard(named: "QRScan")
    }

    func letterCaptureView() -> ImageCaptureView {
        ImageCaptureViewController.loadFromStoryboard(named: "Upload")
    }

    func letterReviewView() -> ImagesReviewView {
        ImagesReviewViewController.loadFromStoryboard(named: "Upload")
    }

    func anotherLetterView() -> LetterAnotherView {
        LetterAnotherViewController.loadFromStoryboard(named: "Upload")
    }

    func evidenceSelectionView() -> EvidenceSelectionView {
        EvidenceSelectionViewController.loadFromStoryboard(named: "Upload")
    }

    func evidenceCaptureView() -> ImageCaptureView {
        ImageCaptureViewController.loadFromStoryboard(named: "Upload")
    }

    func evidenceReviewView() -> ImagesReviewView {
        ImagesReviewViewController.loadFromStoryboard(named: "Upload")
    }

    func selfieCaptureView() -> SelfieCaptureView {
        SelfieCaptureViewController.loadFromStoryboard(named: "Upload")
    }

    func selfieReviewView() -> ImagesReviewView {
        ImagesReviewViewController.loadFromStoryboard(named: "Upload")
    }

    func uploadView() -> UploadEnvelopeView {
        UploadEnvelopeViewController.loadFromStoryboard(named: "Upload")
    }
}

@objc protocol UIStoryboardLoading {}
extension UIViewController : UIStoryboardLoading {}


extension UIStoryboardLoading where Self : UIViewController {

    static func loadFromStoryboard(named name: String, in bundle: Bundle? = nil) -> Self {
        let identifier = "\(self)".split{$0 == "."}.map(String.init).last!
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}


import Foundation

struct ImageData {
    let id = UUID().uuidString
}

protocol ImageCaptureContext {
    var title: String { get }
}

protocol ImageCaptureWorkflow {
    var captureContext: ImageCaptureContext { get }

    func captured(_ image: ImageData)
    func cancel()
}

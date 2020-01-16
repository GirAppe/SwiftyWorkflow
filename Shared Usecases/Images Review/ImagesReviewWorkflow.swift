protocol ImagesReviewContext {
    var title: String { get }
    var images: [ImageData] { get }
}

protocol ImagesReviewWorkflow {
    var reviewContext: ImagesReviewContext { get }

    func confirm()
    func retake()
    func cancel()
}

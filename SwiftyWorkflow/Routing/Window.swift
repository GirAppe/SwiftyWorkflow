import Foundation

public protocol Window: class {
    var rootView: ViewType? { get set }
    func makeKeyAndVisible()
}

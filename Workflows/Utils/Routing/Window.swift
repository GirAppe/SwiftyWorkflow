import Foundation

protocol Window: class {
    var rootView: ViewType? { get set }
    func makeKeyAndVisible()
}

import Foundation

//sourcery: AutoMockable
public protocol WindowContext: class {
    var rootView: NavigationContext? { get set }
    func makeKeyAndVisible()
}

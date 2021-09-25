import Foundation

//sourcery: AutoMockable
public protocol WindowContext: AnyObject {
    var rootView: NavigationContext? { get set }
    func makeKeyAndVisible()
}

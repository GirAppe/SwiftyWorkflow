import UIKit

extension UIWindow: Window {
    public var rootView: ViewType? {
        get { return rootViewController }
        set { rootViewController = newValue as? UIViewController }
    }
}

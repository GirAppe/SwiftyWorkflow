import UIKit

extension UIWindow: Window {
    var rootView: ViewType? {
        get { return rootViewController }
        set { rootViewController = newValue as? UIViewController }
    }
}

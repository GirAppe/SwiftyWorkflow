#if os(iOS) || os(tvOS)
import UIKit.UIWindow

extension UIWindow: WindowContext {

    public var rootView: NavigationContext? {
        get { rootViewController }
        set { rootViewController = newValue as? UIViewController }
    }
}
#endif

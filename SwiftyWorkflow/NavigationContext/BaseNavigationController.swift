#if os(iOS) || os(tvOS)
import UIKit
import Foundation

// MARK: - Base navigation controller

public class BaseNavigationController: UINavigationController {

    /// This class wouldbe used whenever `wrappedInNavigation` modifier is used
    public static var defaultClass: UINavigationController.Type = BaseNavigationController.self

    #if os(iOS)
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }

    public override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }
    #endif
}
#endif

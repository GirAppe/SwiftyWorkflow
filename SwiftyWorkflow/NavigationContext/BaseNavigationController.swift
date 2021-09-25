#if os(iOS) || os(tvOS)
import UIKit
import Foundation

// MARK: - Base navigation controller

open class BaseNavigationController: UINavigationController, NavigationWrappingContext, NavigationContextWithAppearance {

    /// This class would be used whenever `wrappedInNavigation` modifier is used
    public static var defaultClass: NavigationWrappingContext.Type = BaseNavigationController.self

    /// Specify default appearance setup closure.
    public static var appearance: (BaseNavigationController) -> Void = {
        if #available(iOS 13.0, *) {
            $0.navigationBar.standardAppearance = .make {
                $0.configureWithDefaultBackground()
                $0.backgroundColor = .systemBackground
                $0.backgroundEffect = .init(style: .regular)
            }
            $0.navigationBar.scrollEdgeAppearance = .make {
                $0.configureWithDefaultBackground()
                $0.backgroundColor = .systemBackground
                $0.backgroundEffect = .init(style: .regular)
            }
        }
    }

    final public func setupAppearance() {
        BaseNavigationController.appearance(self)
    }

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
#if os(iOS) || os(tvOS)
import UIKit
import Foundation

// MARK: - Deafult UI Navigation

public protocol ContextWithDefaultAppearance {
    func setupDefaultAppearance()
}

// MARK: - Base navigation controller

open class BaseNavigationController: UINavigationController, ContextWithDefaultAppearance {

    /// This class would be used whenever `wrappedInNavigation` modifier is used
    public static var defaultClass: UINavigationController.Type = BaseNavigationController.self

    open func setupDefaultAppearance() {
        if #available(iOS 13.0, *) {
            self.navigationBar.standardAppearance = .make {
                $0.configureWithDefaultBackground()
                $0.backgroundColor = .systemBackground
                $0.backgroundEffect = .init(style: .regular)
            }
            self.navigationBar.scrollEdgeAppearance = .make {
                $0.configureWithDefaultBackground()
                $0.backgroundColor = .systemBackground
                $0.backgroundEffect = .init(style: .regular)
            }
        } else {
            // No fallback here.
        }
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
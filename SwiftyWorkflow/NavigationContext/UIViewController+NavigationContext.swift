#if os(iOS) || os(tvOS)
import Foundation
import UIKit.UIViewController

public struct ViewToDismiss {

    public static var viewTagsToDismiss: [Int] = []
}

// MARK: - UIViewController + NavigationContext

extension UIViewController: NavigationContext {

    public var presentingContext: NavigationContext? { presentingViewController ?? navigationController?.presentingViewController }
    public var presentedContext: NavigationContext? { presentedViewController ?? navigationController?.presentedViewController }
    public var navigationContext: NavigationContext? { (self as? UINavigationController) ?? navigationController ?? parent?.navigationContext }
    public var handleError: (Error) -> Void { { [weak self] error in self?.present(error: error) }}

    // MARK: - Navigation stack operations

    public func push(_ context: NavigationContext, animated: Bool) {
        guard let viewController = context as? UIViewController else { return }
        guard viewController.viewIfLoaded?.window == nil else {
            return debugPrint("Could not push already presented controller")
        }
        guard let nav = navigationContext as? UINavigationController else {
            return debugPrint("Could not push when there is no navigation controller")
        }

        if let navigationToPush = viewController as? UINavigationController {
            var stack = nav.viewControllers
            stack.append(contentsOf: navigationToPush.viewControllers)
            nav.setViewControllers(stack, animated: animated)
        } else {
            nav.pushViewController(viewController, animated: animated)
        }
    }

    public func pop(animated: Bool) {
        let nav = navigationContext as? UINavigationController
        _ = nav?.popViewController(animated: animated)
    }

    public func popToRoot(animated: Bool) {
        let nav = navigationContext as? UINavigationController
        _ = nav?.popToRootViewController(animated: animated)
    }

    public func pop(to source: NavigationContext, animated: Bool) {
        guard let controller = source as? UIViewController else { return }
        let nav = navigationContext as? UINavigationController
        _ = nav?.popToViewController(controller, animated: true)
    }

    // MARK: - Modal presentation operations

    public func present(_ context: NavigationContext, animated flag: Bool) {
        present(context, animated: flag, completion: nil)
    }

    public func present(_ context: NavigationContext, animated flag: Bool, completion: NavigationCompletion?) {
        guard let viewController = context as? UIViewController else { return }
        guard viewController.viewIfLoaded?.window == nil else {
            debugPrint("Could not present already presented controller")
            return
        }
        let source = tabBarController ?? navigationController ?? self

        let presentation = {
            source.present(viewController, animated: flag, completion: completion)
        }

        if let tag = source.presentedViewController?.view.tag, ViewToDismiss.viewTagsToDismiss.contains(tag) {
            source.dismiss(animated: flag, completion: presentation)
        } else if source.presentedViewController is UIAlertController {
            source.dismiss(animated: flag, completion: presentation)
        } else if let presented = source.presentedViewController {
            presented.present(context, animated: flag, completion: completion)
        } else {
            presentation()
        }
    }

    public func present(error: Error) {
        let alert = UIAlertController(
            title: nil,
            message: String(describing: error),
            preferredStyle: UIAlertController.Style.alert
        )
        let source = tabBarController ?? navigationController ?? self
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        source.present(alert, animated: true, completion: nil)
    }

    // MARK: - Helpers

    public func withModalPresentationStyle(_ style: UIModalPresentationStyle) -> NavigationContext {
        self.modalPresentationStyle = style
        return self
    }

    public func wrappedInNavigation() -> NavigationContext {
        wrappedIn(BaseNavigationController.defaultClass)
    }

    public func wrappedIn(_ navigation: NavigationContext) -> NavigationContext {
        guard let navigation = navigation as? UINavigationController else { return self }
        let controllers = (self as? UINavigationController)?.viewControllers ?? [self]
        navigation.setViewControllers(controllers, animated: false)
        return navigation
    }

    public func wrappedIn<T: UINavigationController>(_ navigationClass: T.Type) -> NavigationContext {
        self.wrappedIn(navigationClass.make {
            ($0 as? ContextWithDefaultAppearance)?.setupDefaultAppearance()
        })
    }
}
#endif

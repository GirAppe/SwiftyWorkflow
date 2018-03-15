import UIKit.UIViewController

extension UIViewController: ViewType {
    public var presentingView: ViewType? {
        return presentingViewController ?? navigationController?.presentingViewController
    }
    public var presentedView: ViewType? {
        return presentedViewController ?? navigationController?.presentedViewController
    }
    public var navigationView: ViewType? {
        return (self as? UINavigationController) ?? navigationController ?? parent?.navigationView
    }
    public var handleError: (Error) -> Void {
        return { [weak self] error in
            self?.present(error: error)
        }
    }

    // Navigation stack
    public func push(_ view: ViewType, animated: Bool) {
        guard let viewController = view as? UIViewController else { return }
        let nav = navigationView as? UINavigationController
        nav?.pushViewController(viewController, animated: animated)
    }

    public func pop(animated: Bool) {
        let nav = navigationView as? UINavigationController
        _ = nav?.popViewController(animated: animated)
    }

    public func popToRoot(animated: Bool) {
        let nav = navigationView as? UINavigationController
        _ = nav?.popToRootViewController(animated: animated)
    }

    public func pop(to source: ViewType, animated: Bool) {
        guard let controller = source as? UIViewController else { return }
        let nav = navigationView as? UINavigationController
        _ = nav?.popToViewController(controller, animated: true)
    }

    // Modal
    public func present(_ view: ViewType, animated flag: Bool) {
        present(view, animated: flag, completion: nil)
    }

    public func present(_ view: ViewType, animated flag: Bool, completion: NavigationCompletion?) {
        guard let viewController = view as? UIViewController else { return }
        let source = tabBarController ?? navigationController ?? self
        source.present(viewController, animated: flag, completion: completion)
    }

    public func present(error: Error) {
        let alert = UIAlertController(title: nil, message: String(describing: error), preferredStyle: UIAlertControllerStyle.alert)
        let source = tabBarController ?? navigationController ?? self
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        source.present(alert, animated: true, completion: nil)
    }

    // Other
    public func replace(_ view: ViewType, animated: Bool) {
        if let nav = (self as? UINavigationController) ?? navigationController {
            self.pop(animated: animated)
            nav.push(view, animated: animated)
        } else if self.presentingView != nil {
            weak var presenter = self.presentingView!
            self.dismiss(animated: animated, completion: {
                presenter?.present(view, animated: animated)
            })
        } else if let window = self.view.window {
            window.rootViewController = (view as? UIViewController)
        }
    }

    // Helpers
    public func wrappedInNavigation() -> ViewType {
        guard !(self is UINavigationController) else {
            return self
        }
        let navigation = UINavigationController()
        navigation.setViewControllers([self], animated: false)
        return navigation
    }
}

import UIKit
import SwiftyWorkflow

extension NavigationContext {

    func present(_ dialog: Dialog,
                 animated: Bool = true,
                 completion: @escaping VoidCallback = {}) {
        (self as? UIViewController)?.present(dialog, animated: animated, completion: completion)
    }
}

public extension UIViewController {

    func present(_ dialog: Dialog,
                 animated: Bool = true,
                 completion: @escaping VoidCallback = {}) {
        dialog.show(from: self, animated: animated, completion: completion)
    }
}

protocol AutoMockable {}

public typealias VoidCallback = () -> Void

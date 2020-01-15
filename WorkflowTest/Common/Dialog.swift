import UIKit

public class Dialog {

    public struct Action {
        public enum Style {
            case primary
            case secondary
            case destructive
        }

        public let title: String
        public let style: Style
        public let onTap: VoidCallback

        public init(title: String, style: Style, onTap: @escaping VoidCallback = {}) {
            self.title = title
            self.style = style
            self.onTap = onTap
        }
    }

    public let title: String
    public let message: String
    var actions: [Action] = []

    weak var controller: UIAlertController?

    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    public convenience init(title: String, message: String, actions: [Action]) {
        self.init(title: title, message: message)
        actions.forEach(self.add)
    }

    public func add(_ action: Action) {
        actions.append(action)
    }

    public func show(from source: UIViewController,
                     animated: Bool = true,
                     completion: @escaping VoidCallback) {
        let controller = UIAlertController.controller(for: self)
        self.controller?.dismiss(animated: false, completion: nil)
        self.controller = controller

        source.present(controller, animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool = true,
                        completion: @escaping VoidCallback = {}) {
        controller?.dismiss(animated: animated, completion: completion)
    }
}

extension UIAlertController  {
    
    static func controller(for dialog: Dialog) -> UIAlertController {
        let controller = UIAlertController(title: dialog.title, message: dialog.message, preferredStyle: .alert)
        dialog.actions.forEach { action in
            controller.addAction(UIAlertAction(
                title: action.title,
                style: .init(action.style),
                handler: { _ in action.onTap() }
            ))
        }
        return controller
    }
}

extension UIAlertAction.Style {

    init(_ style: Dialog.Action.Style) {
        switch style {
        case .destructive:
            self = UIAlertAction.Style.default
        default:
            self = UIAlertAction.Style.default
        }
    }
}

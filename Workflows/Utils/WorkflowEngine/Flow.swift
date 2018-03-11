import Foundation

class Flow {
    weak var view: ViewType! = nil
    weak var flowNavigation: NavigationProvider! = nil
    var workflow: WorkflowType?

    deinit {
        debugPrint("[F] Released \(String(describing: self))")
    }
}

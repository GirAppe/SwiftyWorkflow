import Foundation

open class Flow {
    public weak var view: ViewType! = nil
    public weak var flowNavigation: NavigationProvider! = nil
    public var workflow: WorkflowType?

    public init() { }

    deinit {
        debugPrint("[F] Released \(String(describing: self))")
    }
}

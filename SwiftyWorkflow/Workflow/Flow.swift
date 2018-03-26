import Foundation

open class Flow {
    public weak var view: ViewType! {
        get {
            let view = weakView
            strongView = nil    // release after first use
            return view
        }
        set {
            strongView = newValue
            weakView = newValue
        }
    }
    public weak var flowNavigation: NavigationProvider! = nil
    public var workflow: WorkflowType?
    private var strongView: ViewType!
    private weak var weakView: ViewType!

    public init() { }

    deinit {
        debugPrint("[F] Released \(String(describing: self))")
    }
}

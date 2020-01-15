import SwiftyWorkflow

class EvidenceSelectionWorkflow: NavigatableWorkflow, Workflow {

    typealias In = AllowedEvidenceTypes
    enum Event {
        case selected(EvidenceType)
        case cancel
    }

    var allowedEvidenceTypes: AllowedEvidenceTypes!

    func start(with input: AllowedEvidenceTypes) -> NavigationContext {
        self.allowedEvidenceTypes = input

        let view = Factory.instance.evidenceSelectionView()
        view.workflow = self
        return start(with: view)
    }
}

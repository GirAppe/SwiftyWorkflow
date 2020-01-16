import UIKit
import SwiftyWorkflow

class MainWorkflow: NavigatableWorkflow, Workflow {
    typealias In = Void
    typealias Event = Void

    // MARK: - Workflow

    func start(with input: Void) -> NavigationContext? {
        return context ?? UIViewController()
    }

    func startQrScan(from context: NavigationContext) {
        context
            .present(QRScanWorkflow())
            .wrapInNavigation()
            .onEvent { [weak self] event, context in
                switch event {
                case .success(let payload):
                    self?.handleSuccess(with: payload, in: context)
                case .failure:
                    self?.handleFailure(in: context)
                case .cancel:
                    context.dismiss(animated: true)
                }
            }
    }

    func startUpload(with payload: UploadPayload, in context: NavigationContext) {
        context
            .push(UploadWorkflow(), with: payload)
            .onEvent { [weak self] event, context in
                switch event {
                case .success:
                    print("Was huge success...")
                    context.dismiss()
                case .failure(reason: let message):
                    self?.handleFailure(in: context, reason: message)
                case .cancel:
                    context.dismiss()
                }
            }
    }

    // MARK: - Handlers

    private func handleSuccess(with payload: QRCodePayload, in context: NavigationContext) {
        switch payload {
        case .upload(let payload):
            startUpload(with: payload, in: context)
        default:
            print("Unimplemented workflow")
            context.dismiss(animated: true)
        }
    }

    private func handleFailure(in context: NavigationContext, reason: String? =  nil) {
        context.dismiss(animated: true) { [weak self] in
            self?.context?.present(Dialog(
                title: "Failed",
                message: reason ?? "QR Scan failed",
                actions: [
                    .init(title: "OK", style: .secondary)
                ]
            ))
        }
    }
}

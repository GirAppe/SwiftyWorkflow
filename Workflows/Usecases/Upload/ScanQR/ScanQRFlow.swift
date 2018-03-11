//
//  ScanQRFlow.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import SwiftyWorkflow

protocol ScanQRConnector {
    func didScan(document type: DocumentType)
    func didSelectCancelUpload()
}

class ScanQRFlow: Flow, Navigatable, ScanQRConnector {
    typealias In = Void
    class Out: FlowTransition {
        static var ok = Out(DocumentType.self)
        static var cancel = Out(Void.self)
        
        init<T>(_ type: T.Type) { super.init(type) }
    }

    init(resolver: Resolver) {
        super.init()

        let view = resolver.resolve(ScanQRView.self)
        let presenter = resolver.resolve(ScanQRPresenter.self)
        view?.presenter = presenter
        presenter?.connector = self
        self.view = view
    }

    func didScan(document type: DocumentType) {
        perform(.ok, with: type)
    }

    func didSelectCancelUpload() {
        perform(.cancel)
    }
}

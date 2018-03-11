//
//  ScanDocumentFlow.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit.UIImage
import SwiftyWorkflow

enum DocumentType {
    case passport
    case id
    case other
}

protocol ScanDocumentConnector {
    func didScan(document image: UIImage)
    func didSelectCancelUpload()
}

class ScanDocumentFlow: Flow, Navigatable, ScanDocumentConnector {
    typealias In = DocumentType
    struct Out {
        static var ok = Transition<UIImage>()
        static var cancel = Workflow.cancel
    }

    var type: DocumentType

    init(resolver: Resolver, type: DocumentType) {
        self.type = type
        super.init()

        let view = resolver.resolve(ScanDocumentView.self)
        let presenter = resolver.resolve(ScanDocumentPresenter.self, with: type)
        view?.presenter = presenter
        presenter?.connector = self
        self.view = view
    }

    func didScan(document image: UIImage) {
        perform(Out.ok, with: image)
    }

    func didSelectCancelUpload() {
        perform(Out.cancel)
    }
}

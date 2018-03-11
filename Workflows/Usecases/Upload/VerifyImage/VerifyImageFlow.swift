//
//  File.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit.UIImage
import SwiftyWorkflow

protocol VerifyImageConnector {
    func didVerify()
    func didSelectTryAgain()
    func didSelectCancelUpload()
}

class VerifyImageFlow: Flow, Navigatable, VerifyImageConnector {
    typealias In = UIImage
    struct Out {
        static var ok = Workflow.end
        static var cancel = Workflow.cancel
        static var tryAgain = Transition<DocumentType>()
    }

    var type: DocumentType!

    init(resolver: Resolver, image: UIImage) {
        super.init()

        let view = resolver.resolve(VerifyImageView.self)
        let presenter = resolver.resolve(VerifyImagePresenter.self, with: image)
        view?.presenter = presenter
        presenter?.connector = self
        self.view = view
    }

    func didVerify() {
        perform(Out.ok)
    }

    func didSelectTryAgain() {
        perform(Out.tryAgain, with: type)
    }

    func didSelectCancelUpload() {
        perform(Out.cancel)
    }
}

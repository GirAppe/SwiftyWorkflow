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
    class Out: FlowTransition {
        static var success = Out(Void.self)
        static var cancel = Out(Void.self)
        static var tryAgain = Out(Void.self)

        init<T>(_ type: T.Type) { super.init(type) }
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
        perform(.success)
    }

    func didSelectTryAgain() {
        perform(.tryAgain)
    }

    func didSelectCancelUpload() {
        perform(.cancel)
    }
}

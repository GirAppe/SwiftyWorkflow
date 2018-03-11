//
//  VerifyImagePresenter.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol VerifyImagePresenter: class {
    var connector: VerifyImageConnector! { get set }
    var image: UIImage { get }
    var showCancel: Bool { get }

    func doAgain()
    func ok()
    func cancelUpload()
}

class VerifyImagePresenterConcrete: VerifyImagePresenter {
    var connector: VerifyImageConnector!
    var image: UIImage
    var showCancel: Bool = true

    init(image: UIImage) {
        self.image = image
    }

    func doAgain() {
        connector.didSelectTryAgain()
    }

    func ok() {
        connector.didVerify()
    }

    func cancelUpload() {
        connector.didSelectCancelUpload()
    }
}

//
//  ScanQRPresenter.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation

protocol ScanQRPresenter: class {
    var connector: ScanQRConnector! { get set }
    var showCancel: Bool { get }
    var type: DocumentType? { get set } // this would be best with data bindings

    func ok()
    func cancelUpload()
}

class ScanQRPresenterConcrete: ScanQRPresenter {
    var connector: ScanQRConnector!
    var showCancel: Bool = true
    var type: DocumentType?

    func ok() {
        guard let type = self.type else {
            // set error, to make view respond and present error
            return
        }

        connector.didScan(document: type)
    }

    func cancelUpload() {
        connector.didSelectCancelUpload()
    }
}

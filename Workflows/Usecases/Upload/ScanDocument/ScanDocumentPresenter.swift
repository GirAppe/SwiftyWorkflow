//
//  ScanDocumentPresenter.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ScanDocumentPresenter: class {
    var connector: ScanDocumentConnector! { get set }
    var typeName: String { get }
    var showCancel: Bool { get }
    var image: UIImage? { get set } // this would be best with data bindings

    func ok()
    func cancelUpload()
}

class ScanDocumentPresenterConcrete: ScanDocumentPresenter {
    var connector: ScanDocumentConnector!
    var typeName: String
    var showCancel: Bool = true
    var image: UIImage?

    init(type: DocumentType) {
        switch type {
        case .passport: typeName = "Passport"
        case .id: typeName = "ID"
        case .other: typeName = "Other document"
        }
    }

    func ok() {
        guard let image = self.image else {
            // set error, to make view respond and present error
            return
        }

        connector.didScan(document: image)
    }

    func cancelUpload() {
        connector.didSelectCancelUpload()
    }
}

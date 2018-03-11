//
//  ScanQRView.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit
import SwiftyWorkflow

protocol ScanQRView: ViewType {
    var presenter: ScanQRPresenter! { get set }
}

class ScanQRViewController: UIViewController, ScanQRView {
    var presenter: ScanQRPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        if presenter.showCancel {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectCancelUpload(_:)))
        }

        // default - should not be here
        presenter.type = .passport
    }

    @IBAction func didChangeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: presenter.type = .passport
        case 1: presenter.type = .id
        case 2: presenter.type = .other
        default: break
        }
    }

    @IBAction func selectOK(_ sender: Any?) {
        presenter.ok()
    }

    @IBAction func selectCancelUpload(_ sender: Any?) {
        presenter.cancelUpload()
    }
}

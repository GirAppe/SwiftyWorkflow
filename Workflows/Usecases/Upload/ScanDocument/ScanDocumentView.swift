//
//  ScanDocumentView.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit
import SwiftyWorkflow

protocol ScanDocumentView: ViewType {
    var presenter: ScanDocumentPresenter! { get set }
}

class ScanDocumentViewController: UIViewController, ScanDocumentView {
    var presenter: ScanDocumentPresenter!

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if presenter.showCancel {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectCancelUpload(_:)))
        }
        navigationItem.title = presenter.typeName
    }

    @IBAction func didChangeImage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: imageView.image = R.image.cat1()
        case 1: imageView.image = R.image.cat2()
        default: break
        }
    }

    @IBAction func selectOK(_ sender: Any?) {
        presenter.image = imageView.image
        presenter.ok()
    }

    @IBAction func selectCancelUpload(_ sender: Any?) {
        presenter.cancelUpload()
    }
}

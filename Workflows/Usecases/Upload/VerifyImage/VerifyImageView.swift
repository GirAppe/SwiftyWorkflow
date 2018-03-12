//
//  VerifyImageView.swift
//  Workflows
//
//  Created by Andrzej Michnia on 11.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit
import SwiftyWorkflow

protocol VerifyImageView: ViewType {
    var presenter: VerifyImagePresenter! { get set }
}

class VerifyImageViewController: UIViewController, VerifyImageView {
    var presenter: VerifyImagePresenter!

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = presenter.image

        if presenter.showCancel {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(selectCancelUpload(_:)))
        }
    }

    @IBAction func selectOK(_ sender: Any?) {
        presenter.ok()
    }

    @IBAction func selectTryAgain(_ sender: Any?) {
        presenter.doAgain()
    }

    @IBAction func selectCancelUpload(_ sender: Any?) {
        presenter.cancelUpload()
    }
}

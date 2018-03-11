//
//  SettingView.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit
import SwiftyWorkflow

protocol SettingView: ViewType {
    var presenter: SettingPresenter! { get set }
}

class SettingViewController: UIViewController, SettingView {
    var presenter: SettingPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = presenter.name
    }

    @IBAction func didChangeValue(_ sender: UISwitch) {
        presenter.didSet(enabled: sender.isOn)
    }
}

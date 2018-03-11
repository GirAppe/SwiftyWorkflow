//
//  DashboaradView.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit
import SwiftyWorkflow

protocol DashboardView: ViewType {
    var presenter: DashboardPresenter! { get set }
}

class DashboardViewController: UIViewController, DashboardView {
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!

    var presenter: DashboardPresenter!

    @IBAction func selectedUpload(_ sender: Any) {
        presenter.didSelectUpload()
    }

    @IBAction func selectedSettings(_ sender: Any) {
        presenter.didSelectSettings()
    }
}

//
//  DashboardPresenter.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation

protocol DashboardPresenter: class {
    // connector dependency
    var connector: DashboardConnector! { get set }

    // actions
    func didSelectUpload()
    func didSelectSettings()
}

class DashboardPresenterConcrete: DashboardPresenter {
    var connector: DashboardConnector!

    init() { // other dependencies in init

    }

    func didSelectUpload() {

    }

    func didSelectSettings() {

    }
}

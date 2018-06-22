//
//  DashboardConnector.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import SwiftyWorkflow

protocol DashboardConnector {
    func didSelectSettings()
    func didSelectUpload()
}

class DashboardFlow: Flow, Navigatable, DashboardConnector {
    typealias In = Window
    class Out: FlowTransition {
        static var goToSettings = Out(Void.self)
        static var startUpload = Out(Void.self)
    }

    init(resolver: Resolver) {
        super.init()

        let view = resolver.resolve(DashboardView.self)!
        view.presenter.connector = self
        self.view = view
    }

    func didSelectSettings() {
        perform(.goToSettings)
    }

    func didSelectUpload() {
        perform(.startUpload)
    }
}

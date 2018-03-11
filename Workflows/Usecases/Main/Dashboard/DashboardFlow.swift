//
//  DashboardConnector.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation

protocol DashboardConnector {
    func didSelectSettings()
    func didSelectUpload()
}

class DashboardFlow: Flow, Navigatable, DashboardConnector {
    typealias In = Void
    struct Out {
        static var settings = Transition<Void>("settings")
        static var upload = Transition<Void>("upload")
    }

    init(resolver: Resolver) {
        super.init()

        let view = resolver.resolve(DashboardView.self)!
        view.presenter.connector = self
        self.view = view
    }

    func didSelectSettings() {
        perform(Out.settings)
    }

    func didSelectUpload() {
        perform(Out.upload)
    }
}

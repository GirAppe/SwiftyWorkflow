//
//  SettingFlow.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation

protocol SettingConnector {
}

class SettingFlow: Flow, Navigatable, SettingConnector {
    typealias In = Setting
    typealias Out = Void

    init(resolver: Resolver, setting: Setting) {
        super.init()

        let view = resolver.resolve(SettingView.self)!
        let presenter = resolver.resolve(SettingPresenter.self, with: setting)!
        view.presenter = presenter
        presenter.connector = self
        self.view = view
    }
}

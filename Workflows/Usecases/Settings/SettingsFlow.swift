//
//  SwitchConnector.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import SwiftyWorkflow

protocol SettingsConnector {
    func didCancel()
    func didSelect(setting: Setting)
}

class SettingsFlow: Flow, Navigatable, SettingsConnector {
    typealias In = Void
    struct Out {
        static var cancel = Transition<Void>("cancel")
        static var setting = Transition<Setting>("setSettings")
    }
    
    init(resolver: Resolver) {
        super.init()
        let view = resolver.resolve(SettingsView.self)
        self.view = view
        view?.presenter.connector = self
    }

    func didCancel() {
        perform(Out.cancel)
    }

    func didSelect(setting: Setting) {
        perform(Out.setting, with: setting)
    }
}

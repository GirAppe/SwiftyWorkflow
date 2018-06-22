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
    class Out: FlowTransition {
        static var cancel = Out(Void.self)
        static var setting = Out(Setting.self)
    }
    
    init(resolver: Resolver) {
        super.init()
        let view = resolver.resolve(SettingsView.self)
        self.view = view
        view?.presenter.connector = self
    }

    func didCancel() {
        perform(.cancel)
    }

    func didSelect(setting: Setting) {
        perform(.setting, with: setting)
    }
}

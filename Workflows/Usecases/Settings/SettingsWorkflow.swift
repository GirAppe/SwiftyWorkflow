//
//  SettingsWorkflow.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import SwiftyWorkflow

enum Setting: String {
    case enableEmailNotifications
    case enableBiometrics
    case enablePin
}

class SettingsWorkflow: Workflow, Navigatable {
    typealias In = Void
    class Out: FlowTransition { }

    override weak var view: ViewType! {
        get { return super.view ?? self.start() }
        set { super.view = newValue }
    }

    init(resolver: Resolver) {
        super.init()
    }

    override func build() {
        let allSettings = add(SettingsFlow.self, factory: SettingsFlow.init)
        let setting = add(SettingFlow.self, input: Setting.self, factory: SettingFlow.init)

        starts(with: allSettings)
        allSettings.on(.setting, push: setting, animated: true)
    }
}

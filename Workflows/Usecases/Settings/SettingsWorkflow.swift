//
//  SettingsWorkflow.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation

enum Setting: String {
    case enableEmailNotifications
    case enableBiometrics
    case enablePin
}

class SettingsWorkflow: Workflow, Navigatable {
    typealias In = Void
    typealias Out = Void
    struct Entry {
        static var showSetting = Transition<Setting>()
    }

    var main: WorkflowNode<SettingsFlow>!
    override var view: ViewType! {
        get { return main.resolve(with: ()).view ?? super.view }
        set { super.view = newValue }
    }

    override func build() {
        let allSettings = addNode(SettingsFlow.self) { r in
            return SettingsFlow(resolver: r)
        }

        let setting = addNode(SettingFlow.self, input: Setting.self) { r, setting in
            return SettingFlow(resolver: r, setting: setting)
        }

        setEntry(allSettings) { flow -> ViewType in
            return flow.view
        }

        allSettings.connect(to: setting, for: SettingsFlow.Out.setting) { (allSettings, setting) in
            allSettings.view.push(setting.view, animated: true)
        }

        setEntry(setting, for: Entry.showSetting) { (setting, flow) -> ViewType in
            return flow.view
        }

        self.main = allSettings
    }
}

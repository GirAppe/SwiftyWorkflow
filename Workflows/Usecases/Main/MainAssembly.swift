//
//  MainAssembly.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import SwiftyWorkflow

class MainAssembly: Assembly {
    func assemble(in parent: Container) {
        assembleDashboard(in: parent)
        assembleSettings(in: parent)
    }
}

extension MainAssembly {
    func assembleDashboard(in container: Container) {
        container.register(DashboardView.self) { r in
            let view = R.storyboard.main.dashboardViewController()!
            view.presenter = r.resolve(DashboardPresenter.self)
            return view
        }

        container.register(DashboardPresenter.self) { _ in
            return DashboardPresenterConcrete()
        }
    }

    func assembleSettings(in container: Container) {
        container.register(SettingsView.self) { r in
            let view = R.storyboard.settings.settingsViewController()!
            view.presenter = r.resolve(SettingsPresenter.self)
            return view
        }

        container.register(SettingsPresenter.self) { _ in
            return SettingsPresenterConcrete()
        }

        container.register(SettingView.self) { _ in
            return R.storyboard.settings.settingViewController()!
        }

        container.register(SettingPresenter.self, arg: Setting.self) { _, setting in
            return SettingPresenterConcrete(setting: setting)
        }
    }
}

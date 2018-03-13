//
//  SettingsPresenter.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation

protocol SettingsPresenter {
    var connector: SettingsConnector! { get set }
    var numberOfSettings: Int { get }

    func nameForSetting(at indexPath: IndexPath) -> String
    func didSelectSetting(at indexPath: IndexPath)
}

class SettingsPresenterConcrete: SettingsPresenter {
    var connector: SettingsConnector!
    var numberOfSettings: Int { return settings.count }
    var settings: [Setting] = [.enableBiometrics, .enablePin, .enableEmailNotifications]

    func nameForSetting(at indexPath: IndexPath) -> String {
        return settings[indexPath.row].rawValue
    }

    func didSelectSetting(at indexPath: IndexPath) {
        connector.didSelect(setting: settings[indexPath.row])
    }
}

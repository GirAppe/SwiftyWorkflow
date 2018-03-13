//
//  SettingPresenter.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation

protocol SettingPresenter: class {
    var connector: SettingConnector! { get set }
    var name: String { get }
    
    func didSet(enabled: Bool)
}

class SettingPresenterConcrete: SettingPresenter {
    var connector: SettingConnector!
    var name: String

    init(setting: Setting) {
        name = setting.rawValue
    }

    func didSet(enabled: Bool) {
        // use interactor to change settings
    }
}

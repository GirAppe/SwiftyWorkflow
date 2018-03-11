//
//  SettingsView.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import UIKit

protocol SettingsView: ViewType {
    var presenter: SettingsPresenter! { get set }
}

class SettingsViewController: UIViewController, SettingsView {
    var presenter: SettingsPresenter!
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfSettings
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.settingsTTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = presenter.nameForSetting(at: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectSetting(at: indexPath)
    }
}

//
//  ApplicationWorkflow.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import UIKit
import SwiftyWorkflow

class ApplicationWorkflow: Workflow, Navigatable {
    typealias In = Window
    struct Out {
        static var login = Transition<Void>("login")
        static var notification = Transition<Void>("notification")
        static var uploadLink = Transition<String>("uploadLink")
    }
    struct Start {
        static var fromDashboard = Transition<Window>("fromDashboard")
    }

    override func build() {
        let dashboard = self.addNode(DashboardFlow.self) { (resolver) -> DashboardFlow in
            return DashboardFlow(resolver: resolver)
        }

        let settings = addNode(SettingsWorkflow.self) { _ in
            return SettingsWorkflow()
        }

        setEntry(dashboard, for: Start.fromDashboard) { (window, dashboard) in
            window.rootView = dashboard.view.wrappedInNavigation()
            window.makeKeyAndVisible()
            return dashboard.view
        }

        dashboard.connect(to: settings, for: DashboardFlow.Out.settings) { (dashboard, settingsFlow) in
            let view = settingsFlow.start(with: Workflow.start)
            dashboard.view.push(view, animated: true)
        }
    }
}

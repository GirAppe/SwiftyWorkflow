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

        let upload = addNode(UploadWorkflow.self) { _ in
            return UploadWorkflow()
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

        // Upload
        dashboard.connect(to: upload, for: DashboardFlow.Out.upload) { dashboard, upload in
            let view = upload.start().wrappedInNavigation()
            dashboard.view.present(view, animated: true)
        }

        upload.connect(to: dashboard, for: Workflow.end) { _, dashboard in
            dashboard.view.dismiss(animated: true)
        }

        upload.connect(to: dashboard, for: Workflow.cancel) { _, dashboard in
            dashboard.view.dismiss(animated: true)
        }
    }
}

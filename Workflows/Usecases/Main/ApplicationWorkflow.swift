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
    class Out: FlowTransition {
        static var login = Transition<Void>("login")
        static var notification = Transition<Void>("notification")
        static var uploadLink = Transition<String>("uploadLink")

        init<T>(_ type: T.Type) { super.init(type) }
    }
    struct Start {
        static var fromDashboard = Transition<Window>("fromDashboard")
    }

    override func build() {
        // nodes
        let dashboard = self.add(DashboardFlow.self, input: Window.self) { r, _ in
            return DashboardFlow(resolver: r)
        }
        let settings = add(SettingsWorkflow.self, factory: SettingsWorkflow.init)
        let upload = add(UploadWorkflow.self, factory: UploadWorkflow.init)

        // graph
        starts(with: dashboard) { (window, dashboard) -> ViewType in
            window.rootView = dashboard.view.wrappedInNavigation()
            window.makeKeyAndVisible()
            return dashboard.view
        }

        dashboard.on(.goToSettings, push: settings, animated: true)
        dashboard.on(.startUpload, connect: upload) { source, destination in
            let view = destination.start().wrappedInNavigation()
            source.view.present(view, animated: true)
        }

        upload.on(.cancel, .success, unwind: dashboard) { _, dashboard in
            dashboard?.view.dismiss(animated: true)
        }
    }
}

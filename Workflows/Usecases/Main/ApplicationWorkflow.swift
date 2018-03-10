//
//  ApplicationWorkflow.swift
//  Workflows
//
//  Created by Andrzej Michnia on 10.03.2018.
//  Copyright © 2018 Andrzej Michnia. All rights reserved.
//

import Foundation
import UIKit

class ApplicationWorkflow: Workflow, FlowConnector, NavigationProvider {
    typealias In = Window
    struct Out {
        static var login = Transition<Void>()
        static var notification = Transition<Void>()
        static var uploadLink = Transition<String>()
    }
    struct Start {
        static var fromDashboard = Transition<Window>()
    }

    weak var view: ViewType!
    weak var flowNavigation: NavigationProvider! {
        get { return self }
        set { fatalError("Should not be here") }
    }
    var connectors: [String: Any] = [:]

    override func build() {
        let dashboard = self.setNode(DashboardFlow.self) { (resolver) -> DashboardFlow in
            return DashboardFlow(resolver: resolver)
        }

        setInitial(node: dashboard, for: Start.fromDashboard) { [weak self] (window, dashboard) in
            window.rootView = dashboard.view.wrappedInNavigation()
            window.makeKeyAndVisible()
            self?.view = dashboard.view
        }
    }
}

// MARK: - Helpers and protocols implementation
extension ApplicationWorkflow {
    func setInitial<New>(node: WorkflowNode<New>, for transation: Transition<In>, connector: @escaping (In,New) -> Void) where New.In == Void {
        let connect: (In) -> Void = { input in
            let destination = node.resolve(with: ()) // keep destination node alive
            connector(input, destination)
        }
        connectors[transation.id] = connect
    }

    func start(from transition: Transition<In>, with argument: In) throws {
        guard let registered = connectors[transition.id] else {
            throw TransitionError.notSet
        }

        if let intro = registered as? (In) -> Void {
            intro(argument)
        } else {
            throw TransitionError.wrongType
        }
    }

    func connect<New>(to node: WorkflowNode<New>, for transation: Transition<Void>, connector: @escaping (ApplicationWorkflow,New) -> Void) where New.In == Void {
        bridge(to: node, for: transation, bridge: { }, connector: connector)
    }

    func connect<New, Arg>(to node: WorkflowNode<New>, for transation: Transition<Arg>, connector: @escaping (ApplicationWorkflow,New) -> Void) where New.In == Arg {
        bridge(to: node, for: transation, bridge: { $0 }, connector: connector)
    }

    func bridge<New, Arg>(to node: WorkflowNode<New>, for transation: Transition<Arg>, bridge: @escaping (Arg) -> New.In, connector: @escaping (ApplicationWorkflow,New) -> Void) {
        let connect: (Arg,ApplicationWorkflow) -> Void = { output, source in
            let input = bridge(output)
            let destination = node.resolve(with: input) // keep destination node alive
            connector(source, destination)
        }
        connectors[transation.id] = connect
    }

    func move<S>(_ transition: Transition<Void>, from source: S) throws {
        try move(transition, with: (), from: source)
    }

    func move<Arg,S>(_ transition: Transition<Arg>, with argument: Arg, from source: S) throws {
        guard let registered = connectors[transition.id] else {
            throw TransitionError.notSet
        }

        if let connector = registered as? (Arg,S) -> Void {
            connector(argument,source)
        } else if let outro = registered as? (Arg) -> Void {
            outro(argument)
        } else {
            throw TransitionError.wrongType
        }
    }
}

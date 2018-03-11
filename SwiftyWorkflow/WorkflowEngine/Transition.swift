import Foundation
import UIKit.UIImage

typealias ID = String

public struct Transition<A> {
    let id: String

    public init() {
        self.id = UUID().uuidString
    }

    public init(_ id: String) {
        self.id = id
    }
}

extension Transition {
    var name: String { return "-- \(String(describing: A.self)) -- \(id) -->" }
}

public protocol NavigationProvider: class {
    func move<S>(_ transition: Transition<Void>, from source: S) throws
    func move<Arg,S>(_ transition: Transition<Arg>, with argument: Arg, from source: S) throws
}

public enum TransitionError: Error {
    case notSet
    case wrongType
}

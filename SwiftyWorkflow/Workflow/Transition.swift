import Foundation

typealias ID = String

public protocol OutTransition {
    init<T>(_ type: T.Type)
    init<T>(_ type: T.Type, _ id: String)
}

public protocol TransitionConvertible {
    var name: String { get }
    func asTransition<T>() -> Transition<T>?
}

open class FlowTransition: OutTransition, TransitionConvertible {
    let mirror: Mirror
    var id: ID = UUID().uuidString
    public var name: String { return "-- \(String(describing: mirror.subjectType.self)) -- \(id) -->" }

    public required init<T>(_ type: T.Type) {
        self.id = UUID().uuidString
        self.mirror = Mirror(reflecting: T.self)
    }

    public required init<T>(_ type: T.Type, _ id: String) {
        self.id = id
        self.mirror = Mirror(reflecting: T.self)
    }

    public func asTransition<T>() -> Transition<T>? {
        let mirror = Mirror(reflecting: T.self)
        // cast on type if matches. Always can cast on void type
        guard self.mirror.subjectType == mirror.subjectType || mirror.subjectType == Mirror(reflecting: Void.self).subjectType else {
            return nil
        }
        return Transition<T>(id)
    }
}

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

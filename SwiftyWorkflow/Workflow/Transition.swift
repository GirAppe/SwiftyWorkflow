import Foundation

typealias ID = String

public protocol TransitionConvertible {
    var name: String { get }
    func asTransition<T>() -> Transition<T>?
}

open class FlowTransition: TransitionConvertible {
    let mirror: Mirror
    var id: ID = UUID().uuidString
    public var name: String { return "-- \(String(describing: mirror.subjectType.self)) -- \(id) -->" }

    public init<T>(_ type: T.Type, _ id: String = UUID().uuidString) {
        self.id = id
        self.mirror = Mirror(reflecting: T.self)
    }

    public func asTransition<T>() -> Transition<T>? {
        let mirror = Mirror(reflecting: T.self)
        guard self.mirror.subjectType == mirror.subjectType else { return nil }
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

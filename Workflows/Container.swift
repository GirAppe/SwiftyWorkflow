import Foundation

// MARK: - Container
protocol RegsteredInstance {
    func instance<T>(of type: T.Type) -> T?
}
class Registration<T,Arg>: RegsteredInstance {
    enum Scope {
        case none       // fresh instance all the time, default
        case weak       // weak ref to instance,
        case strong     // keep alive
    }

    private var factory: (Arg) -> T
    private var scope: Scope = .none
    private weak var weakInstance: AnyObject?
    private var strongInstance: T?

    init(factory: @escaping (Arg) -> T) {
        self.factory = factory
    }

    func resolve(with input: Arg) -> T {
        switch scope {
        case .none:
            return factory(input)
        case .weak:
            let resolved = (weakInstance as? T) ?? factory(input)
            weakInstance = resolved as AnyObject
            return resolved
        case .strong where strongInstance == nil:
            strongInstance = factory(input)
            fallthrough
        case .strong:
            return strongInstance!
        }
    }

    func instance<T>(of type: T.Type) -> T? {
        return strongInstance as? T ?? weakInstance as? T
    }

    func `in`(scope: Scope) {
        self.scope = scope
    }
}

extension Registration where Arg == Void {
    func resolve() -> T {
        return resolve(with: ())
    }
}

protocol ContainerType: class {
    var parent: ContainerType? { get set }
    var registrations: [RegsteredInstance] { get set }

    @discardableResult func register<T,Arg>(_ type: T.Type, factory: @escaping (Arg) -> T) -> Registration<T,Arg>
    func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T
}

extension ContainerType {
    @discardableResult func register<T,Arg>(_ type: T.Type, factory: @escaping (Arg) -> T) -> Registration<T,Arg> {
        let registration = Registration<T,Arg>(factory: factory)
        registrations.append(registration)
        return registration
    }

    func resolve<T>(_ type: T.Type) -> T {
        return resolve(T.self, with: ())
    }

    func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T {
        if let resolved = self as? T {
            return resolved
        } else if let instance = instance(T.self) {
            return instance
        } else if let registration = registration(T.self, Arg.self) {
            return registration.resolve(with: argument)
        } else if let parent = parent?.registration(T.self, Arg.self) {
            return parent.resolve(with: argument)
        } else {
            fatalError("No registration found for \(T.self) with \(Arg.self)")
        }
    }

    private func instance<T>(_ type: T.Type) -> T? {
        return registrations.flatMap({ $0.instance(of: T.self) }).first
    }
    private func registration<T,Arg>(_ type: T.Type, _ argument: Arg.Type) -> Registration<T,Arg>? {
        return registrations.first { $0 is Registration<T,Arg> } as? Registration<T,Arg>
    }
}

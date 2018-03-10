import Foundation

// MARK: - Resolver
protocol Resolver: class {
    func resolve<T>(_ type: T.Type) -> T!
    func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T!
}

extension Resolver {
    func resolve<T>(_ type: T.Type) -> T {
        return resolve(type, with: ())
    }
}

// MARK: - Container
protocol Container: Resolver {
    var parent: Container? { get set }
    var registrations: [RegsteredInstance] { get set }

    func assemble(in parent: Container?)
    @discardableResult func register<T,Arg>(_ type: T.Type, factory: @escaping (Resolver,Arg) -> T) -> Registration<T,Arg>
}

extension Container {
    func assemble(in parent: Container?) {
        self.parent = parent
    }

    @discardableResult func register<T,Arg>(_ type: T.Type, factory: @escaping (Resolver,Arg) -> T) -> Registration<T,Arg> {
        let registration = Registration<T,Arg> { [unowned self] (argument) -> T in
            return factory(self, argument)
        }
        registrations.append(registration)
        return registration
    }

    func resolve<T>(_ type: T.Type) -> T! {
        return resolve(T.self, with: ())
    }

    func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T! {
        if let resolved = self as? T {
            return resolved
        } else if let instance = instance(T.self) {
            return instance
        } else if let registration = registration(T.self, Arg.self) {
            return registration.resolve(with: argument)
        } else {
            return parent?.resolve(type, with: argument)
        }
    }

    private func instance<T>(_ type: T.Type) -> T? {
        return registrations.flatMap({ $0.instance(of: T.self) }).first // TODO: Verify flow
    }
    private func registration<T,Arg>(_ type: T.Type, _ argument: Arg.Type) -> Registration<T,Arg>? {
        return registrations.first { $0 is Registration<T,Arg> } as? Registration<T,Arg>
    }
}

// MARK: - Registration
protocol RegsteredInstance {
    func instance<T>(of type: T.Type) -> T?
}

class Registration<T,Arg>: RegsteredInstance {
    /// Injection scope. Allows to specify behaviour of resolving registration
    ///
    /// - none: always create new instance when resolving. This is **default** behaviour.
    /// - weak: from 0 to 1 objects at the sime time. If there is no instance, or it was released, create new one. Use existing otherwise.
    /// - strong: container itself keeps strong reference to instance. As long as container is alive, so is the objcet. Always 1 instance.
    enum Scope {
        case none       // fresh instance all the time, default
        case weak       // weak ref to instance, at leas one object
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

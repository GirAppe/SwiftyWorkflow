import Foundation

// MARK: - Container
public protocol Container: Resolver, Assembly {
    var parent: Container? { get set }
    var registrations: [RegsteredInstance] { get set }

    @discardableResult func register<T,Arg>(_ type: T.Type, arg: Arg.Type, factory: @escaping (Resolver,Arg) -> T) -> Registration<T,Arg>
}

public extension Container {
    @discardableResult public func register<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T,Void> {
        return register(type, arg: Void.self) { (resolver: Resolver, arg: Void) -> T in
            return factory(resolver)
        }
    }

    @discardableResult public func register<T,Arg>(_ type: T.Type, arg: Arg.Type, factory: @escaping (Resolver,Arg) -> T) -> Registration<T,Arg> {
        let registration = Registration<T,Arg> { [unowned self] (argument) -> T in
            return factory(self, argument)
        }
        registrations.append(registration)
        return registration
    }

    public func resolve<T>(_ type: T.Type) -> T! {
        return resolve(T.self, with: ())
    }

    public func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T! {
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
public protocol RegsteredInstance {
    func instance<T>(of type: T.Type) -> T?
}

public class Registration<T,Arg>: RegsteredInstance {
    /// Injection scope. Allows to specify behaviour of resolving registration
    ///
    /// - none: always create new instance when resolving. This is **default** behaviour.
    /// - weak: from 0 to 1 objects at the sime time. If there is no instance, or it was released, create new one. Use existing otherwise.
    /// - strong: container itself keeps strong reference to instance. As long as container is alive, so is the objcet. Always 1 instance.
    public enum Scope {
        case none       // fresh instance all the time, default
        case weak       // weak ref to instance, at leas one object
        case strong     // keep alive
    }

    private var factory: (Arg) -> T
    private var scope: Scope = .none
    private weak var weakInstance: AnyObject?
    private var strongInstance: T?

    public init(factory: @escaping (Arg) -> T) {
        self.factory = factory
    }

    public func resolve(with input: Arg) -> T {
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

    public func instance<T>(of type: T.Type) -> T? {
        return strongInstance as? T ?? weakInstance as? T
    }

    public func `in`(scope: Scope) {
        self.scope = scope
    }
}

public extension Registration where Arg == Void {
    public func resolve() -> T {
        return resolve(with: ())
    }
}

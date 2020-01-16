import Foundation

// MARK: - DependencyContainer

public protocol DependencyContainer: Container, Resolver {
    var parent: DependencyContainer? { get set }
}

public extension DependencyContainer {
    
    @discardableResult func register<T>(_ type: T.Type, factory: @escaping (Resolver) -> T) -> Registration<T,Void> {
        return register(type, arg: Void.self) { (resolver: Resolver, arg: Void) -> T in
            return factory(resolver)
        }
    }

    @discardableResult func register<T,Arg>(_ type: T.Type, arg: Arg.Type, factory: @escaping (Resolver,Arg) -> T) -> Registration<T,Arg> {
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
        return registrations.compactMap({ $0.instance(of: T.self) }).first // TODO: Verify flow
    }

    private func registration<T,Arg>(_ type: T.Type, _ argument: Arg.Type) -> Registration<T,Arg>? {
        return registrations.first { $0 is Registration<T,Arg> } as? Registration<T,Arg>
    }
}

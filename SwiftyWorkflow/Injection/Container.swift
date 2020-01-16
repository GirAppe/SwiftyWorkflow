import Foundation

// MARK: - Container

//sourcery: AutoMockable
public protocol Container: class, Assembly {
    var registrations: [RegisteredInstance] { get set }

    @discardableResult func register<T,Arg>(_ type: T.Type, arg: Arg.Type, factory: @escaping (Resolver,Arg) -> T) -> Registration<T,Arg>
}

// MARK: - Registration

public protocol RegisteredInstance {
    func instance<T>(of type: T.Type) -> T?
}

public class Registration<T,Arg>: RegisteredInstance {
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

    public func instance<T>(of type: T.Type) -> T? {
        return strongInstance as? T ?? weakInstance as? T
    }

    public func `in`(scope: Scope) {
        self.scope = scope
    }
}

extension Registration where Arg == Void {
    func resolve() -> T {
        return resolve(with: ())
    }
}

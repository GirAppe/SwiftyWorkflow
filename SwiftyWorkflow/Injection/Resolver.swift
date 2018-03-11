import Foundation

// MARK: - Resolver
public protocol Resolver: class {
    func resolve<T>(_ type: T.Type) -> T!
    func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T!
}

public extension Resolver {
    public func resolve<T>(_ type: T.Type) -> T {
        return resolve(type, with: ())
    }
}

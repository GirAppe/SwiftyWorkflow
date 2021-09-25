import Foundation

// MARK: - Resolver

//sourcery: AutoMockable
public protocol Resolver: AnyObject {
    func resolve<T>(_ type: T.Type) -> T!
    func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T!
}

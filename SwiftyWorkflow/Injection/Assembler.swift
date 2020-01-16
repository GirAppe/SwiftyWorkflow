import Foundation

// MARK: - Assembly

public protocol Assembly {
    func assemble(in parent: DependencyContainer)
}

// MARK: - Assembler

public class Assembler: DependencyContainer {
    public var parent: DependencyContainer?
    public var registrations: [RegisteredInstance] = []

    public init(_ assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(in: self) }
    }

    public func assemble(in parent: DependencyContainer) {
        self.parent = parent
    }

    public func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T! {
        return parent?.resolve(type, with: argument) ?? self.registration(type, Arg.self)?.resolve(with: argument)
    }

    private func instance<T>(_ type: T.Type) -> T? {
        return registrations.compactMap({ $0.instance(of: T.self) }).first
    }
    
    private func registration<T,Arg>(_ type: T.Type, _ argument: Arg.Type) -> Registration<T,Arg>? {
        let exactType = registrations.first { $0 is Registration<T,Arg> } as? Registration<T,Arg>
        return exactType
    }
}

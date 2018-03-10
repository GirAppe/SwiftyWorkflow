import Foundation

class Assembler: Container {
    var parent: Container?
    var registrations: [RegsteredInstance] = []

    init(_ assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(in: self) }
    }

    func assemble(in parent: Container) {
        self.parent = parent
    }

    func resolve<T,Arg>(_ type: T.Type, with argument: Arg) -> T! {
        return parent?.resolve(type, with: argument) ?? self.registration(type, Arg.self)?.resolve(with: argument)
    }

    private func instance<T>(_ type: T.Type) -> T? {
        return registrations.flatMap({ $0.instance(of: T.self) }).first
    }
    private func registration<T,Arg>(_ type: T.Type, _ argument: Arg.Type) -> Registration<T,Arg>? {
        return registrations.first { $0 is Registration<T,Arg> } as? Registration<T,Arg>
    }
}

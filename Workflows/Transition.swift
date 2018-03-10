import Foundation
import UIKit.UIImage

typealias ID = String

struct Transition<A> {
    let id = UUID().uuidString
}

protocol NavigationProvider: class {
    func move<S>(_ transition: Transition<Void>, from source: S) throws
    func move<Arg,S>(_ transition: Transition<Arg>, with argument: Arg, from source: S) throws
}

enum TransitionError: Error {
    case notSet
    case wrongType
}

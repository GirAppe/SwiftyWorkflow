#if os(iOS) || os(tvOS)
import UIKit
#endif
import Foundation

/// Standard completion closure for navigation operation
public typealias NavigationCompletion = () -> Swift.Void

// MARK: - Utils protocols for declarative style

public protocol SimpleInitializable {
    init()
}

public protocol Populatable {}

public extension Populatable where Self: SimpleInitializable {

    static func make(_ populate: (inout Self) -> Void) -> Self {
        var instance = Self.init()
        populate(&instance)
        return instance
    }
}

// MARK: - Conformances

@available(iOS 13.0, *)
extension UINavigationBarAppearance: Populatable, SimpleInitializable {}
extension UIViewController: Populatable, SimpleInitializable {}
extension UIView: Populatable, SimpleInitializable {}

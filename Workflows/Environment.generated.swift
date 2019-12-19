// Generated with AutoEnvironment 0.2.0 by Andrzej Michnia @GirAppe

import Foundation
#if os(iOS)
import UIKit
#endif

/// Abstraction for build configuration/environment
public enum Environment: String {
    case debug = "DEBUG"
    case release = "RELEASE"

    public static var current: Environment {
        if let override = Environment.Override.current {
            return override
        }

        #if DEBUG
        return .debug
        #elseif RELEASE
        return .release
        #else
        return .release
        #endif
    }

    public struct Override {
        public static var current: Environment?
    }
}

// MARK: - Formatting info

public extension Environment {

    var formattedInfo: String {
        var value = (formatForEnvironment[self] ?? defaultFormat).string
        value = value.replacingOccurrences(
            of: Format.Key.environmentName.rawValue,
            with: name)
        value = value.replacingOccurrences(
            of: Format.Key.environmentFirstLetter.rawValue,
            with: abbreviatedName)
        value = value.replacingOccurrences(
            of: Format.Key.versionNumber.rawValue,
            with: appVersion)
        value = value.replacingOccurrences(
            of: Format.Key.buildNumber.rawValue,
            with: appBuildNumber)
        return value
    }

    static func setVersionFormat(_ format: Format) {
        defaultFormat = format
        #if os(iOS)
        Environment.info.update()
        #endif
    }

    static func setVersionFormat(_ format: Format, for environment: Environment) {
        formatForEnvironment[environment] = format
        #if os(iOS)
        Environment.info.update()
        #endif
    }

    enum Format {
        public enum Key: String {
            case environmentName
            case environmentFirstLetter
            case versionNumber
            case buildNumber
        }

        case none
        case simple
        case full
        case just(Key)
        case custom(String)

        public var string: String {
            switch self {
            case .none: return ""
            case .simple: return "\(Key.versionNumber) (\(Key.buildNumber))"
            case .full: return "\(Key.environmentName) \(Format.simple.string)"
            case let .just(key): return key.rawValue
            case let .custom(format): return format
            }
        }
    }
}

// MARK: - Utils

public extension Environment {

    var name: String {
        return rawValue.capitalized
    }

    var abbreviatedName: String {
        return String(name.first!).capitalized
    }

    var appVersion: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        return infoDictionary["CFBundleShortVersionString"] as? String ?? "unknown"
    }

    var appBuildNumber: String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "unknown" }
        return infoDictionary["CFBundleVersion"] as? String ?? "unknown"
    }
}

#if os(iOS)
fileprivate class DummyViewController: UIViewController {
    fileprivate static var shared = DummyViewController()
    fileprivate static var preferredStatusBarStyle: UIStatusBarStyle = .default {
        didSet { shared.setNeedsStatusBarAppearanceUpdate() }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return DummyViewController.preferredStatusBarStyle
    }
}

public extension Environment {
    enum BarType {
        case white
        case black
    }
    static var statusBar: BarType {
        get {
            switch DummyViewController.preferredStatusBarStyle {
            case .default: return .black
            case .lightContent: return .white
            default: return .white
            }
        }
        set {
            switch newValue {
            case .black: DummyViewController.preferredStatusBarStyle = .default
            case .white: DummyViewController.preferredStatusBarStyle = .lightContent
            }
        }
    }

    /// Info container - allows showing environment/configuration version information on top of everything
    static var info = Info()

    class Info {
        public var isHidden: Bool = true {
            didSet { update() }
        }
        public var textAlignment: NSTextAlignment = .left {
            didSet { update() }
        }
        public var textColor: UIColor = .lightGray {
            didSet { update() }
        }
        public var shadowColor: UIColor = .darkGray {
            didSet { update() }
        }

        public func showVersion() {
            isHidden = false
            update()
        }

        public func hideVersion() {
            isHidden = true
            update()
        }

        private var uiwindow: UIWindow?
        private weak var label: UILabel?

        fileprivate init() {}

        private func setupWindowIfNeeded() {
            guard uiwindow == nil else { return }

            let window = UIWindow(frame: UIScreen.main.bounds)
            window.backgroundColor = .clear
            #if swift(>=4.2)
                window.windowLevel = UIWindow.Level.alert + 1
            #else
                window.windowLevel = UIWindowLevelAlert + 1
            #endif
            window.isUserInteractionEnabled = false

            let dummy = DummyViewController.shared
            dummy.view.backgroundColor = UIColor.clear
            window.rootViewController = dummy

            let marginRightView = UIView()
            marginRightView.translatesAutoresizingMaskIntoConstraints = false
            dummy.view.addSubview(marginRightView)
            marginRightView.backgroundColor = .clear
            if #available(iOS 11.0, *) {
                marginRightView.topAnchor.constraint(equalTo: dummy.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            } else {
                marginRightView.topAnchor.constraint(equalTo: dummy.bottomLayoutGuide.topAnchor).isActive = true
            }
            marginRightView.bottomAnchor.constraint(equalTo: dummy.view.bottomAnchor).isActive = true
            marginRightView.rightAnchor.constraint(equalTo: dummy.view.rightAnchor, constant: 0).isActive = true
            marginRightView.widthAnchor.constraint(
                equalTo: marginRightView.heightAnchor,
                multiplier: 0.5
            ).isActive = true

            let marginLeftView = UIView()
            marginLeftView.translatesAutoresizingMaskIntoConstraints = false
            dummy.view.addSubview(marginLeftView)
            marginLeftView.backgroundColor = .clear
            marginLeftView.bottomAnchor.constraint(equalTo: dummy.view.bottomAnchor).isActive = true
            marginLeftView.leftAnchor.constraint(equalTo: dummy.view.leftAnchor, constant: 0).isActive = true
            marginLeftView.widthAnchor.constraint(equalTo: marginRightView.widthAnchor).isActive = true
            marginLeftView.heightAnchor.constraint(equalTo: marginRightView.heightAnchor).isActive = true

            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            dummy.view.addSubview(label)
            label.rightAnchor.constraint(equalTo: marginRightView.leftAnchor, constant: -4).isActive = true
            label.leftAnchor.constraint(equalTo: marginLeftView.rightAnchor, constant: 4).isActive = true
            label.bottomAnchor.constraint(equalTo: dummy.view.bottomAnchor, constant: -1).isActive = true
            label.heightAnchor.constraint(equalToConstant: 12).isActive = true
            label.font = UIFont.systemFont(ofSize: 8)
            label.text = Environment.current.formattedInfo
            label.textAlignment = textAlignment
            label.textColor = textColor
            label.shadowColor = shadowColor
            #if swift(>=4.2)
                dummy.view.bringSubviewToFront(label)
            #else
                dummy.view.bringSubview(toFront: label)
            #endif

            uiwindow = window
            self.label = label
        }

        fileprivate func update() {
            if !isHidden {
                setupWindowIfNeeded()
            }
            label?.text = Environment.current.formattedInfo
            label?.textAlignment = textAlignment
            label?.textColor = textColor
            label?.shadowColor = shadowColor

            uiwindow?.isHidden = isHidden
        }
    }
}
#endif

// MARK: - Private

private var defaultFormat: Environment.Format = .full
private var formatForEnvironment: [Environment: Environment.Format] = [:]

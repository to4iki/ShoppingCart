import UIKit

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}

/// DependencyInjectable
protocol Storyboardable: class, NSObjectProtocol {
    associatedtype Dependency

    static var identifier: String { get }
    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
    static func makeFromStoryboard(dependency: Dependency) -> Self
}

extension Storyboardable {
    static var identifier: String {
        return className
    }

    static var storyboardName: String {
        return className
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

extension Storyboardable {
    static func unsafeMakeFromStoryboard() -> Self {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

extension Storyboardable where Dependency == Void {
    static func makeFromStoryboard(dependency: Dependency) -> Self {
        return unsafeMakeFromStoryboard()
    }

    static func makeFromStoryboard() -> Self {
        return makeFromStoryboard(dependency: ())
    }
}

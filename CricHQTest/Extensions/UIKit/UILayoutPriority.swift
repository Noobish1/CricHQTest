import UIKit

internal extension UILayoutPriority {
    internal static let almostRequired = UILayoutPriority(rawValue: Float(UILayoutPriority.required.rawValue) - 1)
    
    internal static func low(unlessUseRequired useRequired: Bool) -> UILayoutPriority {
        return useRequired ? .almostRequired : .defaultLow
    }
}

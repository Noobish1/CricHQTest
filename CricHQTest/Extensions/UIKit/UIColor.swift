import UIKit

// Adapted from https://stackoverflow.com/a/38435309
internal extension UIColor {
    internal func lighter(by percentage: CGFloat) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }
    
    internal func darker(by percentage: CGFloat) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage))
    }
    
    internal func adjust(by percentage: CGFloat) -> UIColor? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        return UIColor(red: min(red + percentage/100, 1.0),
                       green: min(green + percentage/100, 1.0),
                       blue: min(blue + percentage/100, 1.0),
                       alpha: alpha)
    }
}

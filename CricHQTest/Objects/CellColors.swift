import UIKit

internal struct CellColors {
    internal let background: UIColor
    internal let primary: UIColor
    internal let secondary: UIColor
    internal let detail: UIColor
    
    internal init(tuple: (background: UIColor, primary: UIColor, secondary: UIColor, detail: UIColor)) {
        self.background = tuple.background
        self.primary = tuple.primary
        self.secondary = tuple.secondary
        self.detail = tuple.detail
    }
}

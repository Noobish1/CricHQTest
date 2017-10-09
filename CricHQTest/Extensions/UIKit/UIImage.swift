import UIKit
import Hue

internal extension UIImage {
    // MARK: interface colours
    internal func interfaceColors() -> InterfaceColors {
        let width: CGFloat = 50
        let size = CGSize(width: width, height: width / self.aspectRatio)
        
        return InterfaceColors(tuple: self.colors(scaleDownSize: size))
    }
    
    // MARK: aspect ratios
    internal var aspectRatio: CGFloat {
        return size.width / size.height
    }
    
    // MARK: images made from colours
    internal convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        if let img: CGImage = image.cgImage {
            self.init(cgImage: img)
        } else {
            return nil
        }
    }
    
    internal convenience init?(color: UIColor) {
        self.init(color: color, size: CGSize(width: 1, height: 1))
    }
}

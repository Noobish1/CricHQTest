import UIKit

internal extension UIImage {
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

import UIKit
import Rswift

// MARK: Rswift extensions
internal extension UITableView {
    internal func nb_dequeueReusableCellWithIdentifier<T: UITableViewCell>(_ identifier: ReuseIdentifier<T>, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) else {
            fatalError("Could not dequeue a cell of type \(T.self)")
        }
        
        return cell
    }
}

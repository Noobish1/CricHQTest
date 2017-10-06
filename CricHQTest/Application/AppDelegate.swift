import UIKit
import Then

// MARK: AppDelegate
@UIApplicationMain
internal final class AppDelegate: UIResponder {
    internal var window: UIWindow?
}

// MARK: UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.rootViewController = UINavigationController(rootViewController: MoviesViewController())
            $0.makeKeyAndVisible()
        }
        
        return true
    }
}

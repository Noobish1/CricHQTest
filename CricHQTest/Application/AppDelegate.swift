import UIKit

// MARK: AppDelegate
@UIApplicationMain
internal final class AppDelegate: UIResponder {
    internal var window: UIWindow?
}

// MARK: UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

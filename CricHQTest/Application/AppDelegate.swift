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
        let navController = UINavigationController(rootViewController: MoviesContainerViewController()).then {
            $0.navigationBar.setBackgroundImage(UIImage(color: .charcoal), for: .default)
            $0.navigationBar.tintColor = .white
            $0.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
            $0.navigationBar.barStyle = .black
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.rootViewController = navController
            $0.makeKeyAndVisible()
        }
        
        return true
    }
}

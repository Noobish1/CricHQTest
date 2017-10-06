import UIKit

// MARK: AppDelegate
@UIApplicationMain
internal final class AppDelegate: UIResponder {
    internal var window: UIWindow?
}

// MARK: UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        _ = APIClient.shared.topMovies().subscribe(onSuccess: { topMovies in
            print("topMovies: \(topMovies)")
        }, onError: { error in
            print("error: \(error)")
        })
        
        return true
    }
}

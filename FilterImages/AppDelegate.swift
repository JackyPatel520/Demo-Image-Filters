

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationControl = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
        //to set initial view controller
        let vc = Util.getStoryboard().instantiateViewController(withIdentifier: "Filters")
        vc.title = "name".localized
        navigationControl = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationControl
        window?.makeKeyAndVisible()
        return true
    }
}

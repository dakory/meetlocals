
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let context = EventScreenContext(moduleOutput: nil)
        let container = EventScreenContainer.assemble(with: context)
        let window = UIWindow(frame: UIScreen.main.bounds)
    
        self.window = window
    
    
    let navigationController = UINavigationController(rootViewController: container.viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
}
}

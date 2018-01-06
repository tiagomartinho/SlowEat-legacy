import Instabug
import Mixpanel
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupSDK()
        setTintColor()
        setRootViewController()
        return true
    }

    private func setupSDK() {
        Instabug.start(withToken: "7cdc3b33e85559115d49a0941cd6a89d", invocationEvent: .shake)
        let token = "7afd4b44a2d4522c389212c59ce66886"
        let mixpanel = Mixpanel.sharedInstance(withToken: token)
        mixpanel.enableLogging = false
    }

    private func setTintColor() {
        window?.tintColor = #colorLiteral(red: 0, green: 0.8784313725, blue: 0.5176470588, alpha: 1)
    }

    private func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MealsViewController()
        window?.makeKeyAndVisible()
    }
}

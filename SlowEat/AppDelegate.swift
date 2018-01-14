import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setTintColor()
        setRootViewController()
        return true
    }

    private func setTintColor() {
        window?.tintColor = Color.tint.uiColor
    }

    private func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: MealListViewController())
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.tintColor = Color.green.uiColor
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

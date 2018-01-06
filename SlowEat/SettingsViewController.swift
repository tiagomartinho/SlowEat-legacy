import Instabug
import Mixpanel
import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel?.track("Settings View", properties: nil)
    }

    @IBAction func feedback(_: Any) {
        Instabug.invoke()
    }
}

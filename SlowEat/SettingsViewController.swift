import UIKit
import Instabug
import Mixpanel

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Settings View", properties: nil)
    }

    @IBAction func feedback(_ sender: Any) {
        Instabug.invoke()
    }
}

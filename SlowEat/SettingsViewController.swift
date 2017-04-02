import UIKit
import Instabug
import WatchConnectivity
import Mixpanel
import AudioToolbox

class SettingsViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var slowImageView: UIImageView!
    @IBOutlet weak var mediumImageView: UIImageView!
    @IBOutlet weak var fastImageView: UIImageView!
    @IBOutlet weak var speedSlider: UISlider!

    static let max = 20.0
    static let min = 5.0
    static let b = min
    static let m = (max - b) / Constants.sliderMaximum

    let defaults = UserDefaults.standard

    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activate()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel.track("Settings View", properties: nil)

        tint(imageView: slowImageView)
        tint(imageView: mediumImageView)
        tint(imageView: fastImageView)

        updateUI()
    }

    func updateUI() {
        let userSeconds = defaults.double(forKey: Constants.seconds)
        if userSeconds != 0.0 {
            DispatchQueue.main.async {
                self.speedSlider.value = Float(Constants.sliderMaximum - ((userSeconds - SettingsViewController.b) / SettingsViewController.m))
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        session = WCSession.default()
    }

    func tint(imageView: UIImageView) {
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIApplication.shared.delegate?.window??.tintColor
    }

    @IBAction func feedback(_ sender: Any) {
        Instabug.invoke()
    }

    @IBAction func setSpeed(_ sender: UISlider) {
        speedSlider.value = round(sender.value)
        let seconds = (Constants.sliderMaximum - Double(sender.value)) * SettingsViewController.m + SettingsViewController.b
        defaults.set(seconds, forKey: Constants.seconds)
        session?.sendMessage([Constants.seconds: seconds], replyHandler: nil, errorHandler: nil)
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let userSeconds = message["userSeconds"] as? Double {
            defaults.set(userSeconds, forKey: Constants.seconds)
            updateUI()
        }
        if let _ = message["vibrate"] {
//            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        if let _ = message["start"] {
            let mixpanel = Mixpanel.sharedInstance()
            mixpanel.timeEvent("meal")
        }
        if let _ = message["end"] {
            let mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("meal")
        }
    }
}

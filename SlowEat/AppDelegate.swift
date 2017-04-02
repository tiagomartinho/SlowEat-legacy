import UIKit
import Instabug
import Mixpanel
import WatchConnectivity
import AudioToolbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?

    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activate()
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.tintColor = #colorLiteral(red: 0, green: 0.8784313725, blue: 0.5176470588, alpha: 1)

        Instabug.start(withToken: "7cdc3b33e85559115d49a0941cd6a89d", invocationEvent: .shake)

        let token = "7afd4b44a2d4522c389212c59ce66886"
        let mixpanel = Mixpanel.sharedInstance(withToken: token)
        mixpanel.enableLogging = false

        session = WCSession.default()

        return true
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let _ = message["vibrate"] {
//            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        if let _ = message["start"] {
            let mixpanel = Mixpanel.sharedInstance()
            mixpanel.timeEvent("meal")
            print("start meal")
        }
        if let _ = message["end"] {
            let mixpanel = Mixpanel.sharedInstance()
            mixpanel.track("meal")
            print("end meal")
        }
    }
}

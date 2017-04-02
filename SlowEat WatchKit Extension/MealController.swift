import WatchKit
import Foundation
import WatchConnectivity
import UserNotifications

class MealController: WKInterfaceController {

    private let motionManager = MotionManager()
    private var motionUpdatesInProgress = false
    private var session: WCSession?

    deinit {
        print("deinit")
        motionManager.stopUpdates()
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("awakeWithContext")
        session = WCSession.default()
        session?.activate()
        motionManager.delegate = self
    }

    override func willActivate() {
        super.willActivate()
        print("willActivate")
        if !motionUpdatesInProgress {
            motionManager.startUpdates()
            motionUpdatesInProgress = true
            session?.sendMessage(["start":""], replyHandler: nil, errorHandler: nil)
        }
    }

    override func didAppear() {
        super.didAppear()
        print("didAppear")
    }

    override func willDisappear() {
        super.willDisappear()
        print("willDisappear")
    }

    override func didDeactivate() {
        super.didDeactivate()
        print("didDeactivate")
    }
}

extension MealController: MovementDelegate {
    func waiting() {
        print("waiting")
    }

    func moving() {
        print("moving")
    }
}

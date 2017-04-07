import WatchKit
import Foundation
import WatchConnectivity
import UserNotifications

class MealController: WKInterfaceController {

    @IBOutlet var mealTimeLabel: WKInterfaceLabel!
    @IBOutlet var biteCountLabel: WKInterfaceLabel!

    private let motionManager = MotionManager()
    fileprivate let mealTracker = MealTracker.build()
    private var timer: Timer?
    private var motionUpdatesInProgress = false
    private var session: WCSession?

    deinit {
        motionManager.stopUpdates()
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        mealTracker.start()
        session = WCSession.default()
        session?.activate()
        motionManager.delegate = self
    }

    override func willActivate() {
        super.willActivate()
        startTimer()
        if !motionUpdatesInProgress {
            motionManager.startUpdates()
            motionUpdatesInProgress = true
            session?.sendMessage(["start":""], replyHandler: nil, errorHandler: nil)
        }
    }

    override func didDeactivate() {
        super.didDeactivate()
        stopTimer()
    }

    func updateUI() {
        if let mealTime = mealTracker.mealTime {
            let mealTimeFormatted = TimeFormatter.format(mealTime)
            mealTimeLabel.setText(mealTimeFormatted)
        }
        biteCountLabel.setText("\(mealTracker.biteCount)")
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        timer?.tolerance = 0.5
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension MealController: MovementDelegate {
    func waiting() {
        mealTracker.waiting()
    }

    func moving() {
        mealTracker.moving()
    }
}

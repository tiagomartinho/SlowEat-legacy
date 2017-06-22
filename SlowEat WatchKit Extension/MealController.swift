import WatchKit

class MealController: WKInterfaceController {

    @IBOutlet var mealTimeLabel: WKInterfaceLabel!
    @IBOutlet var biteCountLabel: WKInterfaceLabel!
    @IBOutlet var bitesPerMinuteLabel: WKInterfaceLabel!

    fileprivate var presenter: MealPresenter!

    private let mealTracker = MealTracker.build()
    private let motionManager = MotionManager()
    private var timer: Timer?
    private var motionUpdatesInProgress = false

    deinit {
        presenter.stopMeal()
        motionManager.stopUpdates()
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        presenter = MealPresenter(tracker: mealTracker, logger: MealLogger.build(), repository: CKMealRepository())
        presenter.startMeal()
        motionManager.delegate = self
    }

    override func willActivate() {
        super.willActivate()
        startTimer()
        if !motionUpdatesInProgress {
            motionManager.startUpdates()
            motionUpdatesInProgress = true
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        timer?.tolerance = 0.5
    }

    @objc private func updateUI() {
        if let mealTime = mealTracker.mealTime {
            let mealTimeFormatted = TimeFormatter.format(mealTime)
            mealTimeLabel.setText(mealTimeFormatted)
        }
        biteCountLabel.setText("\(mealTracker.biteCount)")
        bitesPerMinuteLabel.setText("\(mealTracker.bitesPerMinute)")
    }

    override func didDeactivate() {
        super.didDeactivate()
        stopTimer()
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension MealController: MovementDelegate {

    func waiting() {
        presenter.waiting()
    }

    func moving() {
        presenter.moving()
    }
}

class MealPresenter {

    let tracker: Tracker
    let logger: Logger

    init(tracker: Tracker, logger: Logger) {
        self.tracker = tracker
        self.logger = logger
    }

    func startMeal() {
        tracker.start()
        logger.start()
    }
}

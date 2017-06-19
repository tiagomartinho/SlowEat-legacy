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

    func stopMeal() {
        tracker.stop()
        logger.stop()
    }

    func waiting() {
        tracker.waiting()
        logger.log(type: .waiting)
    }

    func moving() {
        tracker.moving()
        logger.log(type: .moving)
    }
}

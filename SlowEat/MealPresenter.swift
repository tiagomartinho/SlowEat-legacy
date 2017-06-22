class MealPresenter {

    let tracker: Tracker
    let logger: Logger
    let repository: MealRepository

    init(tracker: Tracker, logger: Logger, repository: MealRepository) {
        self.tracker = tracker
        self.logger = logger
        self.repository = repository
    }

    func startMeal() {
        tracker.start()
        logger.start()
    }

    func stopMeal() {
        repository.save(meal: Meal(events: logger.events))
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

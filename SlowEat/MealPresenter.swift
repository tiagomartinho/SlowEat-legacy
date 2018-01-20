class MealPresenter {

    weak var view: MealView?
    let tracker: Tracker
    let logger: Logger
    let repository: MealRepository

    init(view: MealView, tracker: Tracker, logger: Logger, repository: MealRepository) {
        self.view = view
        self.tracker = tracker
        self.logger = logger
        self.repository = repository
    }

    func startMeal() {
        repository.hasValidAccount { validAccount in
            if validAccount {
                self.tracker.start()
                self.logger.start()
            } else {
                self.view?.showNoAccountError()
            }
        }
    }

    func stopMeal() {
        let meal = Meal(id: repository.uniqueID, events: logger.events)
        let analysedMeal = MealAnalyser().analyse(meal: meal)
        if analysedMeal.bites > 0 && analysedMeal.timeInterval > 5.0 {
            repository.save(meal: meal)
        }
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

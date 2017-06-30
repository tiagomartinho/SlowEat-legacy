import XCTest
@testable import SlowEat

class MealAnalyserTest: XCTestCase {

    func testGroupNearMovingEvents() {
        let analyser = MealAnalyser()

        let mealAnalysed = analyser.analyse(meal: fiveSecondPaceMeal)

        XCTAssertEqual(fiveSecondPaceMeal.events.count, mealAnalysed.events.count)
        XCTAssertEqual(6, mealAnalysed.events.filter { $0.type == .moving }.count)
        XCTAssertEqual(.moving, mealAnalysed.events[23].type)
        XCTAssertEqual(.waiting, mealAnalysed.events[24].type)
        XCTAssertEqual(.moving, mealAnalysed.events[54].type)
        XCTAssertEqual(.waiting, mealAnalysed.events[55].type)
    }

    func testDoNotGroupNearMovingEventsIfUserDoesNotMoving() {
        let analyser = MealAnalyser()

        let mealAnalysed = analyser.analyse(meal: nonStopMeal)

        XCTAssertEqual(nonStopMeal.events.count, mealAnalysed.events.count)
        XCTAssertEqual(3, mealAnalysed.events.filter { $0.type == .moving }.count)
        XCTAssertEqual(.moving, mealAnalysed.events[11].type)
        XCTAssertEqual(.waiting, mealAnalysed.events[12].type)
    }

    var fiveSecondPaceMeal: Meal {
        let eventsType: [EventType] = [.waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting]
        let times: [TimeInterval] = [520527517.38618398, 520527517.86018097, 520527518.346479, 520527518.83295202, 520527519.31900001, 520527519.80513, 520527520.29154003, 520527520.778005, 520527521.26497501, 520527521.76025897, 520527522.24623299, 520527522.732373, 520527523.21876901, 520527523.70478201, 520527524.19125903, 520527524.67765802, 520527525.16392303, 520527525.64986199, 520527526.13634098, 520527526.62225699, 520527527.10910302, 520527527.595025, 520527528.08124101, 520527528.56751299, 520527529.053774, 520527529.54017103, 520527530.02626401, 520527530.51252401, 520527530.99895698, 520527531.48465902, 520527531.97220498, 520527532.45734203, 520527532.94335198, 520527533.42993301, 520527533.91610903, 520527534.40245998, 520527534.88862699, 520527535.37523597, 520527535.86111897, 520527536.34734899, 520527536.83359599, 520527537.31979603, 520527537.80606002, 520527538.29227799, 520527538.77942598, 520527539.26476502, 520527539.75098097, 520527540.23847401, 520527540.72362399, 520527541.209849, 520527541.69597501, 520527542.18229002, 520527542.66844898, 520527543.15466797, 520527543.64101601, 520527544.12715799, 520527544.61340398, 520527545.09963, 520527545.58575499, 520527546.07211298, 520527546.55836803, 520527547.04467899, 520527547.53085899, 520527548.01712799, 520527548.50333899, 520527548.98958403, 520527549.47580302, 520527549.96202701, 520527550.448457, 520527550.93453801, 520527551.430538, 520527551.91648501, 520527552.40292698, 520527552.89002901, 520527553.38506502, 520527553.87446302, 520527554.35798198, 520527554.84484202, 520527555.33953702, 520527555.82726997, 520527556.312204, 520527556.79982501]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }

    var nonStopMeal: Meal {
        let eventsType: [EventType] = [.moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting]
        let times: [TimeInterval] = [520530206.79963499, 520530207.28350103, 520530207.77824199, 520530208.26354402, 520530208.74221998, 520530209.22835898, 520530209.71421701, 520530210.20050502, 520530210.68665802, 520530211.17321497, 520530211.65947002, 520530212.14566702, 520530212.63186502, 520530213.11887199, 520530213.60430503, 520530214.09030801, 520530214.57645601, 520530215.06280297, 520530215.54894, 520530216.035164, 520530216.52140898, 520530217.00761598, 520530217.49376601, 520530218.05238998, 520530218.475977, 520530218.969621, 520530219.44839001, 520530219.94444197, 520530220.43155003, 520530220.92753601, 520530221.41350001, 520530221.90954602, 520530222.39529598, 520530222.88169998]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        let meal = Meal(events: events)
        return meal
    }

    class MealAnalyser {
        func analyse(meal: Meal) -> Meal {
            var isMoving = false
            let processedEvents = meal.events.map { event -> Event in
                let processedEvent = isMoving ? Event(type: .waiting, date: event.date) : event
                isMoving = (event.type == .moving)
                return processedEvent
            }
            return Meal(events: processedEvents)
        }
    }
}


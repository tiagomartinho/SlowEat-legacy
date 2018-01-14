struct GradedMeal {
    let events: [Event]
    let grades: [Grade]
}

import Foundation

//    Number of bites
//    BPM
//    Total time
//    Start & End Date
//    Percentage of each grade and final grade

extension GradedMeal {

    var bites: Int {
        return events.filter { $0.type == .moving }.count
    }

    var startDate: Date {
        return events.first?.date ?? Date()
    }

    var endDate: Date {
        return events.last?.date ?? Date()
    }
}

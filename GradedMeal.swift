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

    var timeInterval: Double {
        return abs(endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
    }

    var bpm: Int {
        guard timeInterval > 0 else { return 0 }
        let oneMinute = 60
        let bpm = Double(bites * oneMinute) / timeInterval
        return Int(bpm.rounded(.up))
    }
}

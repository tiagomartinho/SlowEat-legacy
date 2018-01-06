struct GradedMeal {
    let events: [Event]
    let grades: [Grade]

    var bites: Int {
        return events.filter { $0.type == .moving }.count
    }
//    Number of bites
//    BPM
//    Total time
//    Start & End Date
//    Percentage of each grade and final grade
}

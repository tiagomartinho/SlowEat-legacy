struct MealCell {
    let identifier: String
    let bpm: String
    let date: String
    let change: String
    let color: Color
}

extension MealCell {
    init(gradedMeal: GradedMeal) {
        identifier = gradedMeal.identifier
        bpm = "\(gradedMeal.bpm)"
        date = gradedMeal.startDate.short
        change = ""
        color = .clear
    }

    init(current: GradedMeal, previous: GradedMeal) {
        identifier = current.identifier
        bpm = "\(current.bpm)"
        date = current.startDate.short
        let deltaBPM = current.bpm - previous.bpm
        if deltaBPM == 0 {
            change = ""
            color = .clear
        } else {
            let delta = "\(String(format: "%+d", deltaBPM)) bpm"
            let previousBPM = Double(previous.bpm)
            if previousBPM == 0 {
                change = ""
                color = .clear
                return
            }
            let percentage = "(\(abs(Int(100 * (Double(deltaBPM) / previousBPM))))%)"
            change = "\(delta) \(percentage)"
            color = deltaBPM < 0 ? .green : .red
        }
    }
}

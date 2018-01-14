struct MealCell {
    let bpm: String
    let date: String
    let change: String
    let color: Color
}

extension MealCell {
    init(gradedMeal: GradedMeal) {
        bpm = "\(gradedMeal.bpm)"
        date = gradedMeal.startDate.short
        change = ""
        color = .clear
    }

    init(current: GradedMeal, previous: GradedMeal) {
        bpm = "\(current.bpm)"
        date = current.startDate.short
        let deltaBPM = current.bpm - previous.bpm
        if deltaBPM == 0 {
            change = ""
            color = .clear
        } else {
            let delta = "\(String(format: "%+d", deltaBPM)) bpm"
            let percentage = "(\(abs(Int(100 * (Double(deltaBPM) / Double(previous.bpm)))))%)"
            change = "\(delta) \(percentage)"
            color = deltaBPM < 0 ? .green : .red
        }
    }
}

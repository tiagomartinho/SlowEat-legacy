enum Grade: String {

    case good, bad, worst

    init?(delta: Double) {
        switch delta {
        case Grade.worst.range:
            self = .worst
        case Grade.bad.range:
            self = .bad
        case Grade.good.range:
            self = .good
        default:
            return nil
        }
    }

    private var range: Range<Double> {
        switch self {
        case .worst:
            return 0.0..<5.0
        case .bad:
            return 5.0..<10.0
        case .good:
            return 10.0..<Double.greatestFiniteMagnitude
        }
    }
}
enum Color {
    case red, green
}

extension Color {
    var uiColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 232.0 / 255.0, green: 76.0 / 255.0, blue: 62.0 / 255.0, alpha: 1)
        case .green:
            return UIColor(red: 121.0 / 255.0, green: 213.0 / 255.0, blue: 113.0 / 255.0, alpha: 1)
        }
    }
}

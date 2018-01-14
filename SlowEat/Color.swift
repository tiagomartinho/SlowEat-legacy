enum Color {
    case red, green, clear, tint
}

import UIKit

extension Color {
    var uiColor: UIColor {
        switch self {
        case .red:
            return UIColor(red: 232.0 / 255.0, green: 76.0 / 255.0, blue: 62.0 / 255.0, alpha: 1)
        case .green:
            return UIColor(red: 121.0 / 255.0, green: 213.0 / 255.0, blue: 113.0 / 255.0, alpha: 1)
        case .clear:
            return UIColor.clear
        case .tint:
            return #colorLiteral(red: 0, green: 0.8784313725, blue: 0.5176470588, alpha: 1)
        }
    }
}

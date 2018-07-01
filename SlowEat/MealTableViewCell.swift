import TinyConstraints
import UIKit

class MealTableViewCell: TableViewCell {

    private var dateLabel: UILabel!

    private let defaultMargin = 10.0
    private let textStyle = UIFontTextStyle.title2

    func set(bpm: String) {
        let size = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        let attributesValue = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        let attributesLabel = [
            NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: textStyle),
            NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)
        ]
        let value = NSMutableAttributedString(string: bpm)
        let label = NSMutableAttributedString(string: " bpm")
        let rangeValue = NSRange(location: 0, length: value.length)
        let rangeLabel = NSRange(location: value.length, length: label.length)
        value.append(label)
        value.setAttributes(attributesValue, range: rangeValue)
        value.setAttributes(attributesLabel, range: rangeLabel)
    }

    func set(date: String) {
        dateLabel.text = date
    }

    override func initView() {
        setViewBackground()
        initDateLabel()
        addDateLabel()
    }

    private func setViewBackground() {
        backgroundColor = .black
    }

    private func initDateLabel() {
        dateLabel = UILabel()
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.25)
    }

    private func addDateLabel() {
        addSubview(dateLabel)
        dateLabel.edgesToSuperview()
    }
}

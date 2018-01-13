import UIKit

class MealTableViewCell: TableViewCell {

    private var dateLabel: UILabel!
    private var bpmLabel: UILabel!
    private var bpmView: UIView!
    private var percentageLabel: UILabel!
    private var percentageView: UIView!

    override func initView() {
        setViewBackground()
        initDateLabel()
        initBpmLabel()
        initPercentageLabel()
        addDateLabel()
        addBpmLabel()
        addPercentageLabel()
    }

    private func setViewBackground() {
        backgroundColor = .black
    }

    private func initDateLabel() {
        dateLabel = UILabel()
        dateLabel.text = "13:13, 17/12/2017"
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.25)
    }

    private func addDateLabel() {
        addSubview(dateLabel)
        constrain(dateLabel, with: [
            equal(\.leadingAnchor, constant: -12.0),
            equal(\.topAnchor, constant: -12.0)
        ])
    }

    private func initBpmLabel() {
        bpmLabel = UILabel()
        let size = UIFont.preferredFont(forTextStyle: .title3).pointSize
        let attributesValue = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        let attributesLabel = [
            NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .title3),
            NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)
        ]
        let value = NSMutableAttributedString(string: "18")
        let label = NSMutableAttributedString(string: " bpm")
        let rangeValue = NSRange(location: 0, length: value.length)
        let rangeLabel = NSRange(location: value.length, length: label.length)
        value.append(label)
        value.setAttributes(attributesValue, range: rangeValue)
        value.setAttributes(attributesLabel, range: rangeLabel)
        bpmLabel.attributedText = value

        bpmView = UIView()
    }

    private func addBpmLabel() {
        bpmView.addSubview(bpmLabel)
        bpmView.constrain(bpmLabel, with: [
            equal(\.leadingAnchor, constant: -12.0),
            equal(\.bottomAnchor, constant: +8.0),
            equal(\.topAnchor, constant: -8.0),
            equal(\.trailingAnchor, constant: +12.0)
        ])
        addSubview(bpmView)
        constrain(bpmView, with: [
            equal(\.leadingAnchor, constant: -4.0),
            equal(\.bottomAnchor, constant: +12.0)
        ])
    }

    private func initPercentageLabel() {
        percentageLabel = UILabel()
        percentageLabel.text = "- 12 bpm (4.5%)"
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont.preferredFont(forTextStyle: .title3)

        percentageView = UIView()
        percentageView.backgroundColor = .green
        percentageView.layer.cornerRadius = 5.0
        percentageView.layer.masksToBounds = true
    }

    private func addPercentageLabel() {
        percentageView.addSubview(percentageLabel)
        percentageView.constrain(percentageLabel, with: [
            equal(\.leadingAnchor, constant: +12.0),
            equal(\.bottomAnchor, constant: +8.0),
            equal(\.topAnchor, constant: -8.0),
            equal(\.trailingAnchor, constant: +12.0)
        ])
        addSubview(percentageView)
        constrain(percentageView, with: [
            equal(\.bottomAnchor, constant: +12.0)
        ])
        percentageView.constrain(bpmLabel, with: [equal(\.leadingAnchor, \.trailingAnchor, constant: 12.0)])
        percentageView.constrain(dateLabel, with: [equal(\.topAnchor, \.bottomAnchor, constant: 16.0)])
    }
}

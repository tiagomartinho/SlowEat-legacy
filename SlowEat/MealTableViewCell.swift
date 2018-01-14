import SnapKit
import UIKit

class MealTableViewCell: TableViewCell {

    private var dateLabel: UILabel!
    private var bpmLabel: UILabel!
    private var bpmView: UIView!
    private var percentageLabel: UILabel!
    private var percentageView: UIView!

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
        bpmLabel.attributedText = value
    }

    func set(date: String) {
        dateLabel.text = date
    }

    func set(percentage: String, color: UIColor) {
        percentageLabel.text = percentage
        percentageView.backgroundColor = color
    }

    override func initView() {
        setViewBackground()
        initDateLabel()
        initBpmView()
        initPercentageView()
        addDateLabel()
        addBpmView()
        addPercentageView()
    }

    private func setViewBackground() {
        backgroundColor = .black
    }

    private func initDateLabel() {
        dateLabel = UILabel()
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.25)
    }

    private func initBpmView() {
        bpmLabel = UILabel()
        bpmLabel.adjustsFontSizeToFitWidth = true
        bpmLabel.textAlignment = .right
        bpmView = UIView()
    }

    private func initPercentageView() {
        percentageLabel = UILabel()
        percentageLabel.adjustsFontSizeToFitWidth = true
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont.preferredFont(forTextStyle: textStyle)
        percentageLabel.textAlignment = .right

        percentageView = UIView()
        percentageView.layer.cornerRadius = 8.0
        percentageView.layer.masksToBounds = true
    }

    private func addDateLabel() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(defaultMargin)
            maker.top.equalToSuperview().inset(defaultMargin)
        }
    }

    private func addBpmView() {
        bpmView.addSubview(bpmLabel)
        addSubview(bpmView)
        bpmLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(defaultMargin)
            maker.bottom.equalToSuperview().inset(defaultMargin)
            maker.trailing.equalToSuperview().inset(defaultMargin)
            maker.leading.equalToSuperview().inset(defaultMargin)
        }
        bpmView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(defaultMargin)
            maker.bottom.equalToSuperview().inset(defaultMargin)
            maker.top.equalTo(dateLabel.snp.bottom).offset(defaultMargin)
            maker.width.equalToSuperview().dividedBy(3).priority(.medium)
            maker.width.lessThanOrEqualTo(200).priority(.high)
        }
    }

    private func addPercentageView() {
        percentageView.addSubview(percentageLabel)
        addSubview(percentageView)
        percentageLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(defaultMargin)
            maker.bottom.equalToSuperview().inset(defaultMargin)
            maker.trailing.equalToSuperview().inset(defaultMargin)
            maker.leading.equalToSuperview().inset(defaultMargin)
        }
        percentageView.snp.makeConstraints { maker in
            maker.leading.equalTo(bpmView.snp.trailing).offset(defaultMargin)
            maker.bottom.equalToSuperview().inset(defaultMargin)
            maker.top.equalTo(dateLabel.snp.bottom).offset(defaultMargin)
            maker.width.equalToSuperview().dividedBy(2).priority(.medium)
            maker.width.lessThanOrEqualTo(200).priority(.high)
        }
    }
}

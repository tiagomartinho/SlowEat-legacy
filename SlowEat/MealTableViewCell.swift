import SnapKit
import UIKit

class MealTableViewCell: TableViewCell {

    private var dateLabel: UILabel!
    private var bpmLabel: UILabel!
    private var bpmView: UIView!
    private var percentageLabel: UILabel!
    private var percentageView: UIView!

    private let defaultMargin = 10.0

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
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.25)
    }

    private func addDateLabel() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(defaultMargin)
            maker.top.equalToSuperview().inset(defaultMargin)
        }
    }

    private func initBpmLabel() {
        bpmLabel = UILabel()
        bpmLabel.adjustsFontSizeToFitWidth = true
        bpmLabel.textAlignment = .right
        bpmView = UIView()
    }

    func set(bpm: String) {
        let size = UIFont.preferredFont(forTextStyle: .title3).pointSize
        let attributesValue = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: size),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        let attributesLabel = [
            NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .title3),
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

    private func addBpmLabel() {
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
            maker.width.equalToSuperview().dividedBy(3).priorityMedium()
            maker.width.lessThanOrEqualTo(200).priorityHigh()
        }
    }

    private func initPercentageLabel() {
        percentageLabel = UILabel()
        percentageLabel.adjustsFontSizeToFitWidth = true
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        percentageLabel.textAlignment = .right

        percentageView = UIView()
        percentageView.layer.cornerRadius = 8.0
        percentageView.layer.masksToBounds = true
    }

    private func addPercentageLabel() {
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
            maker.width.equalToSuperview().dividedBy(2).priorityMedium()
            maker.width.lessThanOrEqualTo(200).priorityHigh()
        }
    }
}

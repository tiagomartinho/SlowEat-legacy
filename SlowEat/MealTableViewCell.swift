import SnapKit
import UIKit

class MealTableViewCell: TableViewCell {

    private var dateLabel: UILabel!
    private var bpmLabel: UILabel!
    private var bpmView: UIView!
    private var percentageLabel: UILabel!
    private var percentageView: UIView!

    private let defaultMargin = 12.0

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
        dateLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(defaultMargin)
            maker.top.equalToSuperview().inset(defaultMargin)
        }
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
        }
    }

    private func initPercentageLabel() {
        percentageLabel = UILabel()
        percentageLabel.text = "- 12 bpm (4.5%)"
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont.preferredFont(forTextStyle: .title3)

        percentageView = UIView()
        let red = UIColor(red: 232.0 / 255.0, green: 76.0 / 255.0, blue: 62.0 / 255.0, alpha: 1)
        let green = UIColor(red: 121.0 / 255.0, green: 213.0 / 255.0, blue: 113.0 / 255.0, alpha: 1)
        percentageView.backgroundColor = green
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
        }
    }
}

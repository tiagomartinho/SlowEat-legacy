import UIKit

class MealTableViewCell: TableViewCell {

    private var dateLabel: UILabel!
    private var bpmLabel: UILabel!

    override func initView() {
        setViewBackground()
        initDateLabel()
        initBpmLabel()
        addDateLabel()
        addBpmLabel()
    }

    private func setViewBackground() {
        backgroundColor = .black
    }

    private func initDateLabel() {
        dateLabel = UILabel()
        dateLabel.text = "13:13, 17/12/2017"
        dateLabel.textColor = .white
    }

    private func addDateLabel() {
        addSubview(dateLabel)
        constrain(dateLabel, with: [
            equal(\.leadingAnchor),
            equal(\.topAnchor, \.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func initBpmLabel() {
        bpmLabel = UILabel()
        bpmLabel.text = "18 bpm"
        bpmLabel.textColor = .white
    }

    private func addBpmLabel() {
        addSubview(bpmLabel)
        constrain(bpmLabel, with: [
            equal(\.leadingAnchor),
            equal(\.bottomAnchor, \.safeAreaLayoutGuide.bottomAnchor)
        ])
        bpmLabel.constrain(dateLabel, with: [equal(\.bottomAnchor, \.topAnchor)])
    }
}

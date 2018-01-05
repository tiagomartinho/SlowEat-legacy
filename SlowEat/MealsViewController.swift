import UIKit
import SnapKit

class MealsViewController: UIViewController {

    var meal: GradedMeal {
        let eventsType: [EventType] = [.waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .moving, .moving, .moving, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting, .waiting]
        let times: [TimeInterval] =  [17.38, 17.86, 18.34, 18.83, 19.31, 19.80, 20.29, 20.77, 21.26, 21.76, 22.24, 22.73, 23.21, 23.70, 24.19, 24.67, 25.16, 25.64, 26.13, 26.62, 27.10, 27.59, 28.08, 28.56, 29.05, 29.54, 30.02, 30.51, 30.99, 31.48, 31.97, 32.45, 32.94, 33.42, 33.91, 34.40, 34.88, 35.37, 35.86, 36.34, 36.83, 37.31, 37.80, 38.29, 38.77, 39.26, 39.75, 40.23, 40.72, 41.20, 41.69, 42.18, 42.66, 43.15, 43.64, 44.12, 44.61, 45.09, 45.58, 46.07, 46.55, 47.04, 47.53, 48.01, 48.50, 48.98, 49.47, 49.96, 50.44, 50.93, 51.43, 51.91, 52.40, 52.89, 53.38, 53.87, 54.35, 54.84, 55.33, 55.82, 56.31, 56.79]
        let events = eventsType.enumerated().map { Event(type: $0.element, date: Date(timeIntervalSinceReferenceDate: times[$0.offset])) }
        return MealAnalyser().analyse(meal: Meal(events: events))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 15, height: 400)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(MealEventCell.self, forCellWithReuseIdentifier: MealEventCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview()
            make.topMargin.equalToSuperview()
            make.trailingMargin.equalToSuperview()
            make.leadingMargin.equalToSuperview()
        }
    }
}

extension MealsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meal.events.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealEventCell.identifier, for: indexPath) as! MealEventCell
        let event = meal.events[indexPath.row]
        if event.type == .moving {
            switch meal.grades[indexPath.row] {
            case .good:
                cell.set(backgroundColor: #colorLiteral(red: 0.006976122037, green: 0.93988657, blue: 0.8289572001, alpha: 1), height: 1)
            case .bad:
                cell.set(backgroundColor: #colorLiteral(red: 0.6711956859, green: 0.988876164, blue: 0.008240561932, alpha: 1), height: 2)
            case .worst:
                cell.set(backgroundColor: #colorLiteral(red: 0.9137254902, green: 0.2705882353, blue: 0.5058823529, alpha: 1), height: 4)
            case .empty:
                cell.set(backgroundColor: .clear, height: 0)
            }
        } else {
            cell.set(backgroundColor: .clear, height: 0)
        }
        return cell
    }
}

extension MealsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: collectionView.frame.size.height * 0.9)
    }
}

class MealEventCell: UICollectionViewCell {

    static let identifier = "CellReuseIdentifier"

    var view: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)

        let trailing = UIView()
        trailing.layer.cornerRadius = 5
        trailing.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        contentView.addSubview(trailing)
        trailing.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(1)
        }

        view = UIView()
        view?.layer.cornerRadius = 5
        contentView.addSubview(view!)
        view?.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Double(1.0)/6.0)
        }
    }

    func set(backgroundColor: UIColor, height: Int) {
        view?.backgroundColor = backgroundColor
        view?.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Double(height)/6.0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

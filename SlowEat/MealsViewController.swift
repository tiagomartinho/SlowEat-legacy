import UIKit
import SnapKit

class MealsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 15, height: 400)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
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
        return 100
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: MealEventCell.identifier, for: indexPath)
    }
}

extension MealsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: collectionView.frame.size.height * 0.9)
    }
}

class MealEventCell: UICollectionViewCell {

    static let identifier = "CellReuseIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView()
        view.layer.cornerRadius = 5
        contentView.addSubview(view)
        let n = Int(arc4random_uniform(8) + 2)
        let height: Int
        switch n {
        case 2:
            view.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.2705882353, blue: 0.5058823529, alpha: 1)
            height = 4
        case 3:
            view.backgroundColor = #colorLiteral(red: 0.6711956859, green: 0.988876164, blue: 0.008240561932, alpha: 1)
            height = 2
        case 4:
            view.backgroundColor = #colorLiteral(red: 0.006976122037, green: 0.93988657, blue: 0.8289572001, alpha: 1)
            height = 1
        default:
            height = 1
        }
        view.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Double(height)/6.0)
            make.trailingMargin.equalToSuperview()
            make.leadingMargin.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

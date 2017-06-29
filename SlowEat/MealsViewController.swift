import UIKit
import SnapKit

class MealsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 15, height: 400)
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
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
        let n = Int(arc4random_uniform(3) + 2)
        let height: Int
        switch n {
        case 2:
            view.backgroundColor = #colorLiteral(red: 0.9273005296, green: 0.09212184876, blue: 0.1360091693, alpha: 1)
            height = 4
        case 3:
            view.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.7411764706, blue: 0.2509803922, alpha: 1)
            height = 2
        default:
            view.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.6823529412, blue: 0.1960784314, alpha: 1)
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

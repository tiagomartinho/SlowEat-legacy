import UIKit

class MealsViewController: UITableViewController {

    private var cells = [MealCell]()

    lazy var presenter: MealListPresenter = {
        MealListPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        title = "Meals"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadMeals()
    }

    private func initTableView() {
        tableView.backgroundColor = .black
        tableView.separatorColor = .darkGray
        tableView.allowsSelection = false
        tableView.register(MealTableViewCell.self, forCellReuseIdentifier: "MealTableViewCell")
        if #available(iOS 11.0, *) {
            tableView.insetsContentViewsToSafeArea = true
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as? MealTableViewCell
        else { return UITableViewCell() }
        let mealCell = cells[indexPath.row]
        cell.set(bpm: mealCell.bpm)
        cell.set(date: mealCell.date)
        cell.set(percentage: mealCell.change, color: mealCell.color.uiColor)
        return cell
    }
}

extension MealsViewController: MealsView {
    func showNoMeals() {
        let label = UILabel()
        label.text = "You have no meals"
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        tableView.backgroundView = label
        tableView.separatorColor = .clear
    }

    func showMeals(cells: [MealCell]) {
        self.cells = cells
        tableView.reloadData()
        tableView.separatorColor = .darkGray
    }
}

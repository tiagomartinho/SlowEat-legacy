import UIKit

class MealListViewController: UITableViewController {

    private var cells = [MealCell]()

    lazy var presenter: MealListPresenter = {
        MealListPresenter(view: self, repository: CKMealRepository())
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
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc func refresh() {
        presenter.loadMeals()
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

extension MealListViewController: MealListView {
    func showNoMeals() {
        DispatchQueue.main.async {
            let label = UILabel()
            label.text = "You have no meals"
            label.textAlignment = .center
            label.backgroundColor = .black
            label.textColor = .white
            self.tableView.backgroundView = label
            self.tableView.separatorColor = .clear
        }
    }

    func showMeals(cells: [MealCell]) {
        DispatchQueue.main.async {
            self.cells = cells
            self.tableView.reloadData()
            self.tableView.separatorColor = .darkGray
            self.tableView.backgroundView = nil
        }
    }

    func showLoading() {
        DispatchQueue.main.async {
            self.tableView.separatorColor = .clear
            let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            activityIndicatorView.startAnimating()
            self.tableView.backgroundView = activityIndicatorView
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

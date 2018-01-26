import RealmSwift
import UIKit

class MealListViewController: UITableViewController {

    private var cells = [MealCell]()

    private let repository = RealmMealRepository()

    lazy var fileTransfer: PhoneFileTransfer = {
        PhoneFileTransfer(session: WatchKitSession(), repository: DefaultsDateRepository(), delegate: self)
    }()

    lazy var presenter: MealListPresenter = {
        MealListPresenter(view: self, repository: repository)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        title = "Meals"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                           target: self,
                                                           action: #selector(deleteMeals))
        navigationItem.leftBarButtonItem?.isEnabled = false
    }

    @objc private func deleteMeals() {
        let alert = UIAlertController(title: "Are you sure you want to delete all meals?",
                                      message: "Deleted meals cannot be recovered.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_: UIAlertAction!) -> Void in
            RealmMealRepository().deleteAll()
            self.presenter.loadMeals()
        }))
        present(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadMeals()
        fileTransfer.sync()
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
        showLoading()
        fileTransfer.sync()
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as? MealTableViewCell
        else {
            return UITableViewCell()
        }
        let mealCell = cells[indexPath.row]
        cell.set(bpm: mealCell.bpm)
        cell.set(date: mealCell.date)
        cell.set(percentage: mealCell.change, color: mealCell.color.uiColor)
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = cells[indexPath.row]
            presenter.deleteMeal(from: cell)
            tableView.reloadData()
        } else {
            super.tableView(tableView, commit: editingStyle, forRowAt: indexPath)
        }
    }
}

extension MealListViewController: MealListView {

    private func show(message: String) {
        DispatchQueue.main.async {
            let label = UILabel()
            label.text = message
            label.textAlignment = .center
            label.backgroundColor = .black
            label.textColor = .white
            self.tableView.backgroundView = label
            self.tableView.separatorColor = .clear
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
    }

    func showNoAccountError() {
        let message = """
        Sign in to your iCloud account to save meals.
        Launch Settings, tap iCloud, and enter your Apple ID.
        """
        show(message: message)
    }

    func showNoMeals() {
        show(message: "You have no meals")
    }

    func showMeals(cells: [MealCell]) {
        DispatchQueue.main.async {
            self.cells = cells
            self.tableView.reloadData()
            self.tableView.separatorColor = .darkGray
            self.tableView.backgroundView = nil
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }

    func showLoading() {
        DispatchQueue.main.async {
            self.tableView.separatorColor = .clear
            self.cells = []
            self.tableView.reloadData()
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

extension MealListViewController: PhoneFileTransferDelegate {

    func notReachable() {
        presenter.loadMeals()
    }

    func didReceive(file: String) {
        guard let fileURL = URL(string: file) else { return }
        var configuration = Realm.Configuration()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let realmURL = documentsDirectory.appendingPathComponent("data.realm")
        if FileManager.default.fileExists(atPath: realmURL.path) {
            try? FileManager.default.removeItem(at: realmURL)
        }
        try? FileManager.default.copyItem(at: fileURL, to: realmURL)
        configuration.fileURL = realmURL
        DispatchQueue.main.async {
            self.repository.set(configuration: configuration)
            self.presenter.loadMeals()
        }
    }
}

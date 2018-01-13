import UIKit

class MealsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        title = "Meals"
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

    override func numberOfSections(in _: UITableView) -> Int {
        return 12
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell")!
    }
}

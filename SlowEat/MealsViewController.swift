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

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 120
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as? MealTableViewCell
        else { return UITableViewCell() }
        cell.set(bpm: "\(indexPath.row)")
        if indexPath.row % 2 == 0 {
            let red = UIColor(red: 232.0 / 255.0, green: 76.0 / 255.0, blue: 62.0 / 255.0, alpha: 1)
            cell.set(percentage: "+ 4 bpm (6.3%)", color: red)
        } else {
            let green = UIColor(red: 121.0 / 255.0, green: 213.0 / 255.0, blue: 113.0 / 255.0, alpha: 1)
            cell.set(percentage: "- 12 bpm (2.5%)", color: green)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        cell.set(date: dateFormatter.string(from: Date()))
        return cell
    }
}

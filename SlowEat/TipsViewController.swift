import Mixpanel
import UIKit

class TipsViewController: UIViewController, UITableViewDataSource {

    let data = [
        ("Keep the screen active to receive visual and audible feedback", #imageLiteral(resourceName: "Screen")),
        ("To keep the screen active longer go to the Apple \"Watch\" application", #imageLiteral(resourceName: "SpringBoard")),
        ("Open \"General\" Settings", #imageLiteral(resourceName: "MyWatch")),
        ("Select the \"Wake Screen\" Settings", #imageLiteral(resourceName: "General")),
        ("Set the option \"Always\" on screen wake show last app and \"Wake for 70 Seconds\" on tap", #imageLiteral(resourceName: "Wake")),
    ]

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let mixpanel = Mixpanel.sharedInstance()
        mixpanel?.track("Tips View", properties: nil)

        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CellFromNib")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellFromNib") as? TableViewCell {
            cell.titleLabel.text = data[indexPath.row].0
            cell.imageCellView.image = data[indexPath.row].1
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }
}

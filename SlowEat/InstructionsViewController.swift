import Mixpanel
import UIKit

class InstructionsViewController: UIViewController, UITableViewDataSource {

    let data = [
        ("Keep your Apple Watch on the same hand that you use to eat", #imageLiteral(resourceName: "Start")),
        ("Follow the instructions on the screen, when it's green and says \"Eat\" take the next bite", #imageLiteral(resourceName: "Eat")),
        ("If it's not green keep your Apple Watch still and wait for the next bite", #imageLiteral(resourceName: "Stop")),
        //                ("If it's time for the next bite your iPhone will vibrate till you take the next bite",#imageLiteral(resourceName: "vibrate")),
        ("You can regulate the speed using the digital crown", #imageLiteral(resourceName: "Speed"))
    ]

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let mixpanel = Mixpanel.sharedInstance()
        mixpanel?.track("Instructions View", properties: nil)

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

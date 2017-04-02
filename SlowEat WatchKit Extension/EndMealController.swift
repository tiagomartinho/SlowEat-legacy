import WatchKit

class EndMealController: WKInterfaceController {

    @IBAction func endMeal() {
        let endAction = WKAlertAction(title: "End", style: .destructive) { _ in
            self.dismiss()
        }
        let cancelAction = WKAlertAction(title: "Cancel", style: .cancel) { _ in }
        presentAlert(withTitle: "Do you want to end the meal?", message: nil, preferredStyle: .alert, actions: [cancelAction, endAction])
    }
}

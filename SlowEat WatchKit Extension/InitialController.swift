import WatchKit

class InitialController: WKInterfaceController {

    @IBOutlet var motivationLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("InitialController - awakeWithContext")
        motivationLabel.setText(Motivation().randomQuote)
    }

    override func willDisappear() {
        super.willDisappear()
        motivationLabel.setText(Motivation().randomQuote)
    }
}

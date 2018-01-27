import UserNotifications
import WatchConnectivity
import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    var fileTransfer: WatchFileTransfer!

    func applicationDidFinishLaunching() {
        let file = ""
        fileTransfer = WatchFileTransfer(session: WatchKitSession(),
                                         repository: DefaultsDateRepository(),
                                         file: file)
    }
}

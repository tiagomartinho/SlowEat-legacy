import UserNotifications
import WatchConnectivity
import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    var fileTransfer: WatchFileTransfer!

    func applicationDidFinishLaunching() {
        fileTransfer = WatchFileTransfer(session: WatchKitSession(),
                                         repository: DefaultsDateRepository(),
                                         file: "file path")
    }
}

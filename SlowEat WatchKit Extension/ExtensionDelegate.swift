import RealmSwift
import UserNotifications
import WatchConnectivity
import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    var fileTransfer: WatchFileTransfer!

    func applicationDidFinishLaunching() {
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? ""
        fileTransfer = WatchFileTransfer(session: WatchKitSession(),
                                         repository: DefaultsDateRepository(),
                                         file: realmURL)
    }
}

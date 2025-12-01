import UIKit
import OSLog

final class AppDelegate: NSObject, UIApplicationDelegate {
    let logger = Logger.forCategory("AppDelegate")

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        application.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        logger.debug("Got token \(deviceToken.stringToken())")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        logger.error("Failed to register for remote notifications \(error.localizedDescription)")
    }
}

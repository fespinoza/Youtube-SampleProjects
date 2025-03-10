import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        application.registerForRemoteNotifications()

        ContentView.listenForTokenToStartActivityViaPush()
        ContentView.listenForTokenToUpdateActivityViaPush()

        return true
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("======== DEVICE TOKEN: \(deviceToken.hexEncodedString())")
    }
}

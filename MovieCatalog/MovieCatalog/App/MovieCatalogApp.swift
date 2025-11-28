import SwiftUI
import UIKit

@main
struct MovieCatalogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootContainer()
        }
    }
}

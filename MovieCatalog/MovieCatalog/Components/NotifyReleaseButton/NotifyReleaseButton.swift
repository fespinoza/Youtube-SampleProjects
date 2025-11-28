import SwiftUI
import MovieModels
import UserNotifications

struct NotifyReleaseButton: View {
    let movieID: MovieID

    @State private var areNotificationsEnabled: Bool = false
    // Stored?

    // Permissions?

    var body: some View {
        Button(action: requestNotificationPermissions) {
            Label("Notify", systemImage: "bell")
                .symbolVariant(areNotificationsEnabled ? .fill : .none)
        }
        .task { await checkNotificationsStatus() }
    }

    func checkNotificationsStatus() async {
        let result = await UNUserNotificationCenter.current().notificationSettings()
        areNotificationsEnabled = result.authorizationStatus == .authorized
        print("\(result.authorizationStatus)")
    }

    func requestNotificationPermissions() {
        Task {
            do {
                let result = try await UNUserNotificationCenter
                    .current()
                    .requestAuthorization(options: [.alert, .badge, .sound])
                print("result! \(result)")
                await checkNotificationsStatus()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        Text("Hello World")
            .toolbar {
                ToolbarItem {
                    NotifyReleaseButton(movieID: .randomPreviewId())
                }
            }
    }
    .previewEnvironment()
}

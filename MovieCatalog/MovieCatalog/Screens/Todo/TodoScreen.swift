import SwiftUI
import UserNotifications

struct TodoScreen: View {
    let title: String

    var body: some View {
        ContentUnavailableView(
            "\(title) not available yet",
            systemImage: "exclamationmark.triangle",
            description: Text("It's part of my plan, but I haven't get to it yet")
        )
        .overlay(alignment: .bottom) {
            Button(action: sendLocalNotification) {
                Text("Local")
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }

    private func sendLocalNotification() {
        scheduleLocalNotification(title: "Hello", body: "World")
    }

    private func scheduleLocalNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        // Trigger immediately as a banner
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        Task {
            do {
                try await UNUserNotificationCenter.current().add(request)
                print("schedule local notification")
            } catch {
                print("Failed to schedule notification: \(error)")
            }
        }
    }
}

#Preview {
    TodoScreen(title: "TODO")
}

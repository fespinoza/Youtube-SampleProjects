import SwiftUI

// swiftlint:disable check_localized_string_bundle_for_text
public struct PushNotificationsDebugView: View {
    @State private var apnsToken: String = ""
    @State private var showPushesInForeground: Bool = false
    @State private var authorizationStatus: String = ""
    @State private var hasRequestedPermissionsAlready: Bool = false
    @State private var delegate: NotificationCenterDelegate = .init()

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                GroupBox("APNS Token") {
                    VStack(spacing: 20) {
                        HStack {
                            Text(apnsToken)
                            Spacer()
                            Button(action: copyApnsToken) {
                                Image(systemName: "doc.on.doc.fill")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .font(.caption)

                        HStack {
                            Text("Authorization Status")
                            Spacer()
                            Text(authorizationStatus)
                                .bold()
                        }
                    }
                }

                GroupBox("Request Permissions") {
                    VStack(spacing: 10) {
                        Button("Request Push Permissions", action: requestPermissions)

                        Button("Request Permission (Provisional)", action: requestProvisionalPermissions)
                    }
                    .padding(.vertical)
                    .disabled(hasRequestedPermissionsAlready)

                    Group {
                        if hasRequestedPermissionsAlready {
                            Text("""
                            **Permissions already requested**
                            You need to go to the Settings app to change settings
                            """)
                        } else {
                            Text("You can only request permissions once, choose wisely")
                        }
                    }
                    .font(.caption.italic())
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                }

                GroupBox("Sending Notifications") {
                    Button("Schedule local notification", action: sendLocalNotification)
                    Text("It will appear in 5 seconds")
                        .font(.caption.italic())
                        .foregroundStyle(.secondary)
                }

                GroupBox("Additional Options") {
                    VStack(alignment: .leading) {
                        Toggle("Show Pushes in Foreground", isOn: $showPushesInForeground)
                        Text("By default this is **off**")
                            .font(.caption.italic())
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
        .buttonStyle(.borderedProminent)
        .navigationTitle("Notifications Demo")
        .onChange(of: showPushesInForeground, { _, newValue in
            toggleShowPushesInForeground(newValue)
        })
        .onAppear {
            apnsToken = APNSTokenStorage.getToken()
        }
        .task { await checkPermissions() }
    }

    func checkPermissions() async {
        let result = await UNUserNotificationCenter.current().notificationSettings()
        hasRequestedPermissionsAlready = result.authorizationStatus != .notDetermined
        authorizationStatus = result.authorizationStatus.name
    }

    func copyApnsToken() {
        UIPasteboard.general.string = apnsToken
    }

    func requestPermissions() {
        Task {
            do {
                try await UNUserNotificationCenter
                    .current()
                    .requestAuthorization(options: [.alert, .badge, .sound])
                await checkPermissions()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func requestProvisionalPermissions() {
        Task {
            do {
                try await UNUserNotificationCenter
                    .current()
                    .requestAuthorization(options: [.alert, .badge, .sound, .provisional])
                await checkPermissions()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Sample notification"
        content.body = "This notification was sent locally from the app!"

        // 5 seconds
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

    func toggleShowPushesInForeground(_ enabled: Bool) {
        if enabled {
            UNUserNotificationCenter.current().delegate = delegate
        } else {
            UNUserNotificationCenter.current().delegate = nil
        }
    }
}

@Observable
class NotificationCenterDelegate: NSObject {}

extension NotificationCenterDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.banner, .list, .sound]
    }
}

extension UNAuthorizationStatus {
    var name: String {
        switch self {
        case .notDetermined: "Not Determined"
        case .denied: "Denied"
        case .authorized: "Authorized"
        case .provisional: "Provisional"
        case .ephemeral: "Ephemeral"
        @unknown default: "Unknown case!!!"
        }
    }
}

#Preview {
    NavigationStack {
        PushNotificationsDebugView()
    }
}

// swiftlint:enable check_localized_string_bundle_for_text

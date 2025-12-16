import Foundation

// Disclaimer: this code is just for example purposes, do not use in production
public struct APNSTokenStorage {
    private static let key: String = "apns_token"

    public static func storeToken(_ data: Data) {
        UserDefaults.standard.set(data.stringToken(), forKey: key)
    }

    public static func getToken() -> String {
        UserDefaults.standard.string(forKey: key) ?? "??"
    }
}

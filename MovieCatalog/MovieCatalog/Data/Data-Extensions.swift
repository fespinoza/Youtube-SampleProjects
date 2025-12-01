import Foundation

extension Data {
    /// Converts a token data to string
    func stringToken() -> String {
        reduce("") { $0 + String(format: "%02x", $1) }
    }
}

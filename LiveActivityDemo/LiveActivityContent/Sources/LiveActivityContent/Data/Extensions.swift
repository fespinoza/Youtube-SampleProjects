import Foundation

public extension Int {
    var minutes: TimeInterval {
        60 * TimeInterval(self)
    }
}

import SwiftUI

/// For data coming from the backend, this represents the common
/// states for the data
public enum BasicLoadingState<Value> {
    /// No request has been made
    case idle
    /// There is a request in progress
    case loading
    /// There was a successful request and the data
    /// was parsed correctly
    case dataLoaded(_ value: Value)
    /// There was an error either fetching data, compiling, etc.
    case error(_ error: Error)

    /// A way to differentiate betweeh the types of states
    /// intended for descriptions and animation that depend only
    /// on the difference in state, not the underlying data
    public var typeName: String {
        switch self {
        case .idle: "idle"
        case .loading: "loading"
        case .dataLoaded: "dataLoaded"
        case .error: "error"
        }
    }

    public var value: Value? {
        guard case let .dataLoaded(value) = self else { return nil }
        return value
    }

    public var error: Error? {
        guard case let .error(error) = self else { return nil }
        return error
    }
}

extension BasicLoadingState: Equatable where Value: Equatable {
    public static func == (
        lhs: BasicLoadingState<Value>,
        rhs: BasicLoadingState<Value>
    ) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading):
            return true
        case let (.dataLoaded(lhsValue), .dataLoaded(rhsValue)):
            return lhsValue == rhsValue
        case let (.error(lhsError), .error(rhsError)):
            return (lhsError as NSError) == (rhsError as NSError)
        default:
            return false
        }
    }
}

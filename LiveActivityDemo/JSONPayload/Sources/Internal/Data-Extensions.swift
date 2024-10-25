import Foundation

extension Data {
    enum PrettyJSONError: Error {
        case noData
        case noObject
    }

    var jsonObject: [String: Any] {
        get throws {
            let object = try JSONSerialization.jsonObject(with: self, options: [])
            guard let value = object as? [String: Any] else {
                throw PrettyJSONError.noObject
            }
            return value
        }
    }

    var prettyPrintedJSONString: String {
        get throws {
            let object = try JSONSerialization.jsonObject(with: self, options: [])
            let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])

            guard let string = String(data: data, encoding: .utf8) else {
                throw PrettyJSONError.noData
            }

            return string
        }
    }
}

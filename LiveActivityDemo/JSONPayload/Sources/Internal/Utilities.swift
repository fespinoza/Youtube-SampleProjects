import Foundation

func printJSON(for pushPayload: PushPayload<some Codable>) throws {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970

    let jsonData = try encoder.encode(pushPayload)

    try print(jsonData.prettyPrintedJSONString)
}

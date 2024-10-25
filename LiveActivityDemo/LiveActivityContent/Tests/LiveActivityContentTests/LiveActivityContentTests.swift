import Foundation
@testable import LiveActivityContent
import Testing

@Test func decodingJSON() async throws {
    let optionalData = """
    {
        "blueTeamScore" : 2,
        "matchState" : {
            "inProgress" : {
                "periodInfo" : {
                    "name" : "1st half",
                    "currentTime" : 1730927755.065562,
                    "timeLeft" : 2700
                }
            }
        },
        "redTeamScore" : 1
    }
    """.data(using: .utf8)

    let jsonData = try #require(optionalData)

    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    let content = try decoder.decode(ScoreActivityAttributes.ContentState.self, from: jsonData)

    #expect(content.blueTeamScore == 2)
    #expect(content.redTeamScore == 1)

    if case let .inProgress(periodInfo) = content.matchState {
        #expect(periodInfo.name == "1st half")
        #expect(periodInfo.currentTime.timeIntervalSince1970 == 1_730_927_755.065562)
        #expect(periodInfo.timeLeft == 2700)
    } else {
        Issue.record("not the right matchState")
    }
}

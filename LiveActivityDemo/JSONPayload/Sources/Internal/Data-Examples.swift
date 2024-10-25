import Foundation
import LiveActivityContent

extension JSONEncoder {
    static func pushDecoder(debug: Bool) -> JSONEncoder {
        let decoder = JSONEncoder()
        if debug {
            decoder.dateEncodingStrategy = .iso8601
        } else {
            // This is important to ensure
            // LiveActivities work well with the dates
            // passed to the console
            decoder.dateEncodingStrategy = .secondsSince1970
        }
        return decoder
    }
}

func beforeMatch(debug: Bool) throws -> String {
    let push = PushPayload(
        aps: StartApsContent(
            contentState: ScoreActivityAttributes.ContentState(
                matchState: .notYetStarted,
                blueTeamScore: 0,
                redTeamScore: 0
            ),
            attributesType: "ScoreActivityAttributes",
            attributes: ScoreActivityAttributes(
                blueTeam: .init(
                    name: "Man United",
                    imageName: "manchester"
                ),
                redTeam: .init(
                    name: "Arsenal",
                    imageName: "arsenal"
                ),
                matchStartTime: Date()
            )
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func matchStart(debug: Bool) throws -> String {
    let push = PushPayload(
        aps: UpdateApsContent(
            contentState: ScoreActivityAttributes.ContentState(
                matchState: .inProgress(
                    periodInfo: .init(
                        name: "1st half",
                        currentTime: Date(),
                        timeLeft: 45 * 60
                    )
                ),
                blueTeamScore: 0,
                redTeamScore: 0
            )
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func firstGoal(debug: Bool) throws -> String {
    let push = PushPayload(
        aps: UpdateApsContent(
            contentState: ScoreActivityAttributes.ContentState(
                matchState: .inProgress(
                    periodInfo: .init(
                        name: "1st half",
                        currentTime: Date(),
                        timeLeft: 25.minutes
                    )
                ),
                blueTeamScore: 1,
                redTeamScore: 0
            )
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func halfTime(debug: Bool) throws -> String {
    let push = PushPayload(
        aps: UpdateApsContent(
            contentState: ScoreActivityAttributes.ContentState(
                matchState: .paused,
                blueTeamScore: 1,
                redTeamScore: 1
            )
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func secondGoal(debug: Bool) throws -> String {
    let push = PushPayload(
        aps: UpdateApsContent(
            contentState: ScoreActivityAttributes.ContentState(
                matchState: .inProgress(
                    periodInfo: .init(
                        name: "2nd half",
                        currentTime: Date(),
                        timeLeft: 30.minutes
                    )
                ),
                blueTeamScore: 1,
                redTeamScore: 1
            )
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func thirdGoal(debug: Bool) throws -> String {
    let push = PushPayload(
        aps: UpdateApsContent(
            contentState: ScoreActivityAttributes.ContentState(
                matchState: .inProgress(
                    periodInfo: .init(
                        name: "2nd half",
                        currentTime: Date(),
                        timeLeft: 5.minutes
                    )
                ),
                blueTeamScore: 2,
                redTeamScore: 1
            )
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

func matchEnd(debug: Bool) throws -> String {
    let push = PushPayload(
        aps: EndApsContent(
            contentState: ScoreActivityAttributes.ContentState(
                matchState: .finished,
                blueTeamScore: 2,
                redTeamScore: 1
            )
        )
    )
    let data = try JSONEncoder.pushDecoder(debug: debug).encode(push)
    return try data.prettyPrintedJSONString
}

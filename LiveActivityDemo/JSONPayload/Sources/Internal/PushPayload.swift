import Foundation

struct PushPayload<Content: Codable>: Codable {
    let aps: Content
}

protocol ApsContent: Codable {}

struct StartApsContent<AttributeType: Codable, ContentState: Codable>: ApsContent {
    let timestamp: Date = .init()
    let event: String = "start"
    let contentState: ContentState
    let attributesType: String
    let attributes: AttributeType
    let alert: Alert = .init(title: "Start title", body: "Start body")

    enum CodingKeys: String, CodingKey {
        case timestamp
        case event
        case contentState = "content-state"
        case attributesType = "attributes-type"
        case attributes
        case alert
    }
}

struct UpdateApsContent<ContentState: Codable>: ApsContent {
    let timestamp: Date = .init()
    let event: String = "update"
    let contentState: ContentState
    let alert: Alert = .init(title: "Update title", body: "Update body")

    enum CodingKeys: String, CodingKey {
        case timestamp
        case event
        case contentState = "content-state"
        case alert
    }
}

struct EndApsContent<ContentState: Codable>: ApsContent {
    let timestamp: Date = .init()
    let event: String = "end"
    let contentState: ContentState
    let dismissalDate: Date = .init().addingTimeInterval(60)
    let alert: Alert = .init(title: "End title", body: "End body")

    enum CodingKeys: String, CodingKey {
        case timestamp
        case event
        case contentState = "content-state"
        case alert
    }
}

struct Alert: Codable {
    let title: String?
    let body: String?
    let subtitle: String?
    let badge: Int?
    let sound: String?

    init(
        title: String? = nil,
        body: String? = nil,
        subtitle: String? = nil,
        badge: Int? = nil,
        sound: String? = nil
    ) {
        self.title = title
        self.body = body
        self.subtitle = subtitle
        self.badge = badge
        self.sound = sound
    }
}

import SwiftUI
import MovieModels
import Tagged
import PreviewData

public struct MovieCardViewData: Identifiable, Equatable {
    public let id: MovieID
    public let title: String
    public let image: ImageViewData
    public let style: Style

    public init(
        id: MovieID,
        title: String,
        image: ImageViewData,
        style: Style = .basic
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.style = style
    }

    public enum Style: Equatable {
        case basic
        case upcoming(releaseDate: String)
        case ranking(ranking: String)
    }
}

public extension MovieCardViewData {
    static let defaultImage: Image = Image.defaultMoviePoster

    static func basic(from summary: MovieSummary) -> Self {
        .init(
            id: summary.id,
            title: summary.title,
            image: .remote(from: summary.posterURL, defaultImage: defaultImage),
            style: .basic
        )
    }

    static func upcoming(from summary: MovieSummary) -> Self {
        .init(
            id: summary.id,
            title: summary.title,
            image: .remote(from: summary.posterURL, defaultImage: defaultImage),
            style: (
                summary.releaseDate.flatMap {
                    .upcoming(
                        releaseDate: Utils.formattedUpcomingReleaseDate(from: $0)
                    )
                }
            ) ?? .basic
        )
    }

    static func ranking(from summary: MovieSummary, ranking: Int) -> Self {
        .init(
            id: summary.id,
            title: summary.title,
            image: .remote(from: summary.posterURL, defaultImage: defaultImage),
            style: .ranking(ranking: "#\(ranking)")
        )
    }
}

public extension MovieCardViewData {
    static func previewValue(
        id: MovieID = .randomPreviewId(),
        title: String = "Gladiator II",
        image: ImageViewData? = nil,
        style: MovieCardViewData.Style = .basic
    ) -> Self {
        .init(
            id: id,
            title: title,
            image: image ?? .image(Image(preview: .Movie.Poster.Gladiator.small)),
            style: style
        )
    }

    static func gladiatorTwo() -> Self {
        .previewValue(
            title: "Gladiator II",
            image: .image(Image(preview: .Movie.Poster.Gladiator.small))
        )
    }

    static func kindaPregnant() -> Self {
        .previewValue(
            title: "Kinda Pregnent",
            image: .image(Image(preview: .Movie.Poster.KindaPregnant.small))
        )
    }

    static func eternalSunshine() -> Self {
        .previewValue(
            title: "Eternal Sunshine of the Spotless Mind",
            image: .image(Image(preview: .Movie.Poster.EternalSunshine.small))
        )
    }

    static func ironMan() -> Self {
        .previewValue(
            id: .init(1_182_047),
            title: "Iron Man",
            image: .image(Image(preview: .Movie.Poster.IronMan.small))
        )
    }
}

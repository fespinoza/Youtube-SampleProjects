import SwiftUI

struct MovieDetailsViewData: Identifiable, Equatable {
    let id: MovieID
    let title: String
    let genres: [String]
    let description: String
    let runtime: String
    let releaseYear: String
    let releaseDate: String
    let poster: ImageViewData
    let actors: [ActorViewData]
    let galleryItems: [ImageContainerViewData]

    struct ImageContainerViewData: Hashable {
        let image: ImageViewData
        let aspectRatio: CGFloat
    }

    struct ActorViewData: Identifiable, Equatable {
        let id: ActorID
        let name: String
        let characterName: String
        let profilePicture: ImageViewData
    }
}

extension MovieDetailsViewData {
    init(dto: MovieDetails) {
        let actors = if dto.credits.cast.count >= 10 {
            dto.credits.cast.prefix(10).map(ActorViewData.init(dto:))
        } else {
            dto.credits.cast.map(ActorViewData.init(dto:))
        }

        self.init(
            id: dto.id,
            title: dto.title,
            genres: dto.genres.map(\.name),
            description: dto.overview ?? "",
            runtime: Utils.formatRuntime(minutes: dto.runtime),
            releaseYear: Utils.formattedReleaseYear(from: dto.releaseDate),
            releaseDate: Utils.formattedReleaseDate(from: dto.releaseDate),
            poster: .remote(from: dto.imageURL),
            actors: actors,
            galleryItems: dto
                .images
                .backdrops
                .dropFirst()
                .prefix(10)
                .map({ backdrop in
                    .init(
                        image: .remote(from: backdrop.imageURL),
                        aspectRatio: backdrop.aspectRatio
                    )
                })
        )
    }
}

extension MovieDetailsViewData.ActorViewData {
    init(dto: CastMember) {
        self.init(
            id: dto.id,
            name: dto.name,
            characterName: dto.character,
            profilePicture: .remote(from: dto.profilePictureSmall)
        )
    }
}

extension MovieDetailsViewData {
    static func previewValue(
        id: MovieID = .randomPreviewId(),
        title: String = "The Apprentice",
        genres: [String] = ["History", "Drama"],
        description: String = """
        A young Donald Trump, eager to make his name as a hungry scion \
        of a wealthy family in 1970s New York, comes under the spell of \
        Roy Cohn, the cutthroat attorney who would help create the Donald \
        Trump we know today. Cohn sees in Trump the perfect protégé—someone \
        with raw ambition, a hunger for success, and a willingness to do \
        whatever it takes to win.
        """,
        runtime: String = "2h 2m",
        releaseYear: String = "2024",
        releaseDate: String = "October 9th, 2024",
        poster: ImageViewData = .image(Image(.Movie.TheApprentice.medium)),
        actors: [MovieDetailsViewData.ActorViewData] = [
            .previewValue(),
            .previewValue(),
            .previewValue(),
            .previewValue(),
        ],
        galleryItems: [ImageContainerViewData] = [
            .init(
                image: .image(Image(.Movie.EternalSunshine.medium)),
                aspectRatio: 0.7
            ),
            .init(
                image: .image(Image(.Movie.EternalSunshine.medium)),
                aspectRatio: 0.7
            ),
        ]
    ) -> Self {
        .init(
            id: id,
            title: title,
            genres: genres,
            description: description,
            runtime: runtime,
            releaseYear: releaseYear,
            releaseDate: releaseDate,
            poster: poster,
            actors: actors,
            galleryItems: galleryItems
        )
    }
}
extension MovieDetailsViewData.ActorViewData {
    static func previewValue(
        id: ActorID = .randomPreviewId(),
        name: String = "Sebastian Stan",
        characterName: String = "Donald Trump",
        profilePicture: ImageViewData = .image(Image(.Actor.BradPitt.small))
    ) -> Self {
        .init(
            id: id,
            name: name,
            characterName: characterName,
            profilePicture: profilePicture
        )
    }
}

import SwiftUI

struct ImageContainerViewData: Identifiable, Hashable {
    let id = UUID()
    let image: ImageViewData
    let aspectRatio: CGFloat
}

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
            poster: .remote(from: dto.posterURL, defaultImage: Image(.missingPoster)),
            actors: actors,
            galleryItems: dto
                .images
                .backdrops
                .dropFirst()
                .prefix(10)
                .map { backdrop in
                    .init(
                        image: .remote(from: backdrop.imageURL),
                        aspectRatio: backdrop.aspectRatio
                    )
                }
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
        title: String = "Iron Man",
        genres: [String] = ["Action", "Science Fiction", "Adventure"],
        description: String = """
        After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized \
        suit of armor to fight evil.
        """,
        runtime: String = "2h 6m",
        releaseYear: String = "2008",
        releaseDate: String = "May 30th, 2028",
        poster: ImageViewData? = .image(Image(.Movie.IronMan.medium)),
        actors: [MovieDetailsViewData.ActorViewData] = [
            .previewValue(),
            .previewValue(),
            .previewValue(),
            .previewValue(),
        ],
        galleryItems: [ImageContainerViewData] = [
            .previewValue(image: .image(Image(.Gallery.IronMan.image1))),
            .previewValue(image: .image(Image(.Gallery.IronMan.image2))),
            .previewValue(image: .image(Image(.Gallery.IronMan.image3))),
            .previewValue(image: .image(Image(.Gallery.IronMan.image4))),
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
            poster: poster ?? .image(Image(.missingPoster)),
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

extension ImageContainerViewData {
    static func previewValue(
        image: ImageViewData = .image(Image(.Gallery.TheApprentice.image2)),
        aspectRatio: CGFloat = 1.778
    ) -> Self {
        .init(
            image: image,
            aspectRatio: aspectRatio
        )
    }
}

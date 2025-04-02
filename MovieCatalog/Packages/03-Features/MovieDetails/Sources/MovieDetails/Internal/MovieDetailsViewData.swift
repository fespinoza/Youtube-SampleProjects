import SwiftUI
import MovieModels
import MovieComponents
import Navigation
import PreviewData
import Tagged

public struct MovieDetailsViewData: Sendable, Identifiable, Equatable {
    public let id: MovieID
    public let title: String
    public let genres: [String]
    public let description: String
    public let runtime: String
    public let releaseYear: String
    public let releaseDate: String
    public let poster: ImageViewData
    public let actors: [ActorViewData]
    public let galleryItems: [ImageContainerViewData]
    public let galleryItemsDto: [MovieDetails.ImageCollection.Backdrop]

    public init(
        id: MovieID,
        title: String,
        genres: [String],
        description: String,
        runtime: String,
        releaseYear: String,
        releaseDate: String,
        poster: ImageViewData,
        actors: [ActorViewData],
        galleryItems: [ImageContainerViewData],
        galleryItemsDto: [MovieDetails.ImageCollection.Backdrop]
    ) {
        self.id = id
        self.title = title
        self.genres = genres
        self.description = description
        self.runtime = runtime
        self.releaseYear = releaseYear
        self.releaseDate = releaseDate
        self.poster = poster
        self.actors = actors
        self.galleryItems = galleryItems
        self.galleryItemsDto = galleryItemsDto
    }

    public struct ActorViewData: Sendable, Identifiable, Equatable {
        public let id: ActorID
        public let name: String
        public let characterName: String
        public let profilePicture: ImageViewData

        public init(id: ActorID, name: String, characterName: String, profilePicture: ImageViewData) {
            self.id = id
            self.name = name
            self.characterName = characterName
            self.profilePicture = profilePicture
        }
    }
}

extension MovieDetailsViewData {
    public init(dto: MovieDetails) {
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
            poster: .remote(from: dto.posterURL, defaultImage: Image.missingPoster),
            actors: actors,
            galleryItems: ImageContainerViewData.galleryItems(for: dto),
            galleryItemsDto: dto.images.backdrops
        )
    }
}

extension MovieDetailsViewData.ActorViewData {
    public init(dto: CastMember) {
        self.init(
            id: dto.id,
            name: dto.name,
            characterName: dto.character,
            profilePicture: .remote(from: dto.profilePictureSmall)
        )
    }
}

extension MovieDetailsViewData {
    public static func previewValue(
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
        poster: ImageViewData? = .image(Image(preview: .Movie.IronMan.medium)),
        actors: [MovieDetailsViewData.ActorViewData] = [
            .previewValue(),
            .previewValue(),
            .previewValue(),
            .previewValue(),
        ],
        galleryItems: [ImageContainerViewData] = [
            .previewValue(image: .image(Image(preview: .Gallery.IronMan.image1))),
            .previewValue(image: .image(Image(preview: .Gallery.IronMan.image2))),
            .previewValue(image: .image(Image(preview: .Gallery.IronMan.image3))),
            .previewValue(image: .image(Image(preview: .Gallery.IronMan.image4))),
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
            poster: poster ?? .image(Image.missingPoster),
            actors: actors,
            galleryItems: galleryItems,
            galleryItemsDto: []
        )
    }
}

extension MovieDetailsViewData.ActorViewData {
    public static func previewValue(
        id: ActorID = .randomPreviewId(),
        name: String = "Robert Downey Jr.",
        characterName: String = "Tony Stark",
        profilePicture: ImageViewData = .image(Image(preview: .Actor.BradPitt.small))
    ) -> Self {
        .init(
            id: id,
            name: name,
            characterName: characterName,
            profilePicture: profilePicture
        )
    }
}

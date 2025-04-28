import SwiftUI
import MovieModels
import MovieComponents

struct ActorDetailsViewData: Identifiable, Equatable {
    let id: ActorID
    let name: String
    let profilePicture: ImageViewData
    let bio: String
    let movies: [MovieCardViewData]
}

extension ActorDetailsViewData {
    init(dto: ActorDetails) {
        self.init(
            id: dto.id,
            name: dto.name,
            profilePicture: .remote(from: dto.profilePictureMedium),
            bio: dto.biography,
            movies: dto.movieCredits.cast.prefix(10).map { MovieCardViewData.basic(from: $0) }
        )
    }
}

extension ActorDetailsViewData {
    static func previewValue(
        id: ActorID = .randomPreviewId(),
        name: String = "Pedro Pascal",
        profilePicture: ImageViewData = .image(Image(.Actor.PedroPascal.medium)),
        bio: String = """
        José Pedro Balmaceda Pascal (born April 2, 1975) is a Chilean and American actor. After nearly two decades \
        of taking minor roles on stage and television, Pascal had his breakout role as Oberyn Martell in the fourth \
        season of the HBO fantasy series Game of Thrones (2014). He gained further prominence with his portrayal of \
        Javier Peña in the Netflix crime series Narcos (2015–2017). He went on to appear in the films The Great Wall \
        (2016), Kingsman: The Golden Circle (2017), The Equalizer 2 (2018), and Triple Frontier (2019).\n\nPascal's \
        leading roles as Din Djarin in the Disney+ science fiction series The Mandalorian (2019–2023) and Joel Miller \
        in the HBO post-apocalyptic drama series The Last of Us (2023–present)...
        """,
        movies: [MovieCardViewData] = [
            .gladiatorTwo(),
            .eternalSunshine(),
            .kindaPregnant(),
            .ironMan(),
        ]
    ) -> Self {
        .init(
            id: id,
            name: name,
            profilePicture: profilePicture,
            bio: bio,
            movies: movies
        )
    }
}

import SwiftUI

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
            movies: dto.movieCredits.cast.prefix(10).map({ MovieCardViewData.basic(from: $0) })
        )
    }
}

extension ActorDetailsViewData {
    static func previewValue(
        id: ActorID = .randomPreviewId(),
        name: String = "Pedro Pascal",
        profilePicture: ImageViewData = .image(Image(.Actor.BradPitt.medium)),
        bio: String = """
        A young Donald Trump, eager to make his name as a hungry scion of a wealthy family in 1970s New York, \
        comes under the spell..
        """,
        movies: [MovieCardViewData] = [
            .gladiatorTwo(),
            .eternalSunshine(),
            .kindaPregnant(),
            .theApprentice(),
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

import SwiftUI
import MovieModels
import MovieComponents
import PreviewData
import Navigation

enum SearchResultViewData: Identifiable, Equatable {
    case movie(_: MovieResultViewData)
    case actor(_: ActorResultViewData)

    var id: String {
        switch self {
        case let .movie(viewData): "movie-\(viewData.id.rawValue)"
        case let .actor(viewData): "actor-\(viewData.id.rawValue)"
        }
    }
}

extension SearchResultViewData {
    init(dto: SearchResult) {
        switch dto {
        case let .movie(movieSummary):
            self = .movie(.init(dto: movieSummary))
        case .actor(let actorSummary):
            self = .actor(.init(dto: actorSummary))
        }
    }
}

struct ActorResultViewData: Identifiable, Equatable {
    let id: ActorID
    let name: String
    let profileImage: ImageViewData
}

extension ActorResultViewData {
    init(dto: ActorSummary) {
        self.init(
            id: dto.id,
            name: dto.name,
            profileImage: .remote(from: dto.profileURL, defaultImage: Image.defaultActorProfile)
        )
    }
}

struct MovieResultViewData: Identifiable, Equatable {
    let id: MovieID
    let title: String
    let releaseYear: String
    let image: ImageViewData
}

extension MovieResultViewData {
    init(dto: MovieSummary) {
        self.init(
            id: dto.id,
            title: dto.title,
            releaseYear: Utils.formattedReleaseYear(from: dto.releaseDate),
            image: .remote(from: dto.backdropURL, defaultImage: Image.defaultMovieBanner)
        )
    }
}

struct SearchResultCell: View {
    let viewData: SearchResultViewData

    var body: some View {
        Group {
            switch viewData {
            case let .movie(movieViewData):
                movieCell(for: movieViewData)

            case let .actor(actorViewData):
                actorCell(for: actorViewData)
            }
        }
        .font(.callout)
    }

    func movieCell(for movieViewData: MovieResultViewData) -> some View {
        NavigationButton(push: .movieDetails(id: movieViewData.id)) {
            HStack(spacing: .spacingS) {
                CustomAsyncImage(state: movieViewData.image) { image in
                    image
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 120, height: 80)
                .clipShape(.rect(cornerRadius: 6))

                VStack(alignment: .leading) {
                    Text(movieViewData.title)

                    Text("Movie - \(movieViewData.releaseYear)")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .contentShape(Rectangle())
        }
    }

    func actorCell(for actorViewData: ActorResultViewData) -> some View {
        NavigationButton(push: .actorDetails(id: actorViewData.id)) {
            HStack(spacing: .spacingS) {
                ProfilePictureView(image: actorViewData.profileImage)

                VStack(alignment: .leading) {
                    Text(actorViewData.name)
                    Text("Actor")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .contentShape(Rectangle())
        }
    }
}

private struct Demo: View {
    @State var content: SearchResultViewData

    init(movie: MovieResultViewData = .previewValue()) {
        self._content = .init(initialValue: .movie(movie))
    }

    init(actor: ActorResultViewData = .previewValue()) {
        self._content = .init(initialValue: .actor(actor))
    }

    var body: some View {
        SearchResultCell(viewData: content)
    }
}

#Preview {
    List {
        Demo(movie: .previewValue())
        Demo(movie: .previewValue(title: "Eternal sunshine of the spotless mind"))
        Demo(actor: .previewValue())
    }
    .environment(Router.previewRouter())
}

extension MovieResultViewData {
    static func previewValue(
        id: MovieID = .randomPreviewId(),
        title: String = "How to Train Your Dragon",
        releaseYear: String = "2010",
        image: ImageViewData = .image(Image(preview: .Movie.Backdrop.IronMan.small))
    ) -> Self {
        .init(
            id: id,
            title: title,
            releaseYear: releaseYear,
            image: image
        )
    }
}

extension ActorResultViewData {
    static func previewValue(
        id: ActorID = .randomPreviewId(),
        name: String = "Pedro Pascal",
        profileImage: ImageViewData = .image(Image(preview: .Actor.PedroPascal.medium))
    ) -> Self {
        .init(
            id: id,
            name: name,
            profileImage: profileImage
        )
    }
}

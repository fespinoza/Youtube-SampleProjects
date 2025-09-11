import SwiftUI
import MovieModels
import Navigation
import MovieComponents

struct FeatureMovieViewData: Identifiable, Equatable {
    let id: MovieID
    let title: String
    let image: ImageViewData
    let genre: String
    let releaseYear: String
    let description: String
}

extension FeatureMovieViewData {
    @MainActor static func build(from dto: MovieSummary, genreStore: GenreStore) -> Self {
        self.init(
            id: dto.id,
            title: dto.title,
            image: .remote(from: dto.posterURL, defaultImage: Image(.missingPoster)),
            genre: genreStore.firstGenre(for: dto.genreIds),
            releaseYear: Utils.formattedReleaseYear(from: dto.releaseDate),
            description: dto.overview ?? "" // TODO: this should be non-optional
        )
    }
}

struct FeaturedMoviesView: View {
    let featuredMovies: [FeatureMovieViewData]

    var body: some View {
        TabView {
            ForEach(featuredMovies) { movie in
                NavigationButton(push: .movieDetails(id: movie.id)) {
                    CardView(viewData: movie)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .aspectRatio(4.0 / 6.0, contentMode: .fit)
        .frame(minHeight: 600)
    }

    struct CardView: View {
        let viewData: FeatureMovieViewData

        var body: some View {
            image
                .overlay { readableGradient }
                .overlay(alignment: .bottom) { content }
                .contentShape(Rectangle())
                .tint(.primary)
        }

        var image: some View {
            CustomAsyncImage(state: viewData.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipped()
        }

        var readableGradient: some View {
            LinearGradient(
                stops: [
                    .init(color: .clear, location: 0.6),
                    .init(color: .black, location: 1.0),
                ],
                startPoint: .init(x: 0, y: 0),
                endPoint: .init(x: 0, y: 1.0)
            )
        }

        var content: some View {
            VStack(spacing: .spacingSM) {
                VStack(spacing: .spacingXS) {
                    Text(viewData.title)
                        .multilineTextAlignment(.center)
                        .font(.title.bold())

                    HStack(spacing: .spacingS) {
                        Text(viewData.genre)
                        Text(viewData.releaseYear)
                    }
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
                }

                Text(viewData.description)
                    .font(.caption)
                    .lineLimit(3)
            }
            .padding(.horizontal, .spacingM)
            .padding(.bottom, .spacingXL)
            .colorScheme(.dark)
        }
    }
}

#Preview {
    FeaturedMoviesView.CardView(viewData: .ironMan())
}

#Preview {
    FeaturedMoviesView(
        featuredMovies: [
            .ironMan(),
            .eternalSunshine(),
            .gladiatorTwo(),
        ]
    )
}

extension FeatureMovieViewData {
    static func previewValue(
        id: MovieID = .randomPreviewId(),
        title: String = "Iron Man",
        image: ImageViewData = .image(Image(.Movie.IronMan.medium)),
        genre: String = "Science Fiction",
        releaseYear: String = "2008",
        description: String = """
        After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized \
        suit of armor to fight evil.
        """
    ) -> Self {
        .init(
            id: id,
            title: title,
            image: image,
            genre: genre,
            releaseYear: releaseYear,
            description: description
        )
    }

    static func ironMan(
        image: ImageViewData = .image(Image(.Movie.IronMan.medium))
    ) -> Self {
        .init(
            id: .randomPreviewId(),
            title: "Iron Man",
            image: image,
            genre: "Science Fiction",
            releaseYear: "2008",
            description: """
            After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized \
            suit of armor to fight evil.
            """
        )
    }

    static func eternalSunshine(
        image: ImageViewData = .image(Image(.Movie.EternalSunshine.medium))
    ) -> Self {
        .init(
            id: .randomPreviewId(),
            title: "Eternal Sunshine of the Spotless Mind",
            image: image,
            genre: "Science Fiction",
            releaseYear: "2004",
            description: "Joel Barish, heartbroken that his girlfriend underwent a procedure to erase him from her memory, decides to do the same. However, as he watches his memories of her fade away, he realises that he still loves her, and may be too late to correct his mistake."
        )
    }

    static func gladiatorTwo(
        image: ImageViewData = .image(Image(.Movie.Gladiator.medium))
    ) -> Self {
        .init(
            id: .randomPreviewId(),
            title: "Gladiator II",
            image: image,
            genre: "Action",
            releaseYear: "2024",
            description: "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people."
        )
    }
}

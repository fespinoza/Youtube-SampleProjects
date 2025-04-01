import SwiftUI
import MovieModels
import Navigation
import MovieComponents

struct HomeView: View {
    let viewData: HomeViewData
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: .spacingL) {
                FeaturedMoviesView(featuredMovies: viewData.featuredMovies)
                    .overlay {
                        if colorScheme == .dark {
                            LinearGradient(
                                stops: [
                                    .init(color: .black.opacity(0.7), location: 0.0),
                                    .init(color: .clear, location: 0.3),
                                ],
                                startPoint: .init(x: 0, y: 0),
                                endPoint: .init(x: 0, y: 1.0)
                            )
                            .allowsHitTesting(false)
                        }
                    }

                MovieHorizontalGallery(
                    title: "New Movies",
                    destination: .popular,
                    movies: viewData.newMovies
                )

                MovieHorizontalGallery(
                    title: "Top Movies",
                    destination: .topRated,
                    movies: viewData.topRatedMovies
                )

                MovieHorizontalGallery(
                    title: "Upcoming Movies",
                    destination: .upcoming,
                    movies: viewData.upcomingMovies
                )
            }
            .padding(.bottom, .spacingL)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

#Preview {
    NavigationStack {
        HomeView(viewData: .previewValue())
            .navigationTitle("Movies")
    }
}

struct MovieHorizontalGallery: View {
    let title: String
    let destination: MovieListType
    let movies: [MovieCardViewData]

    var body: some View {
        ContentSection(title: title, destination: .movieList(destination)) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: .spacingML) {
                    ForEach(movies) { movie in
                        NavigationButton(push: .movieDetails(id: movie.id)) {
                            MovieCardView(viewData: movie)
                        }
                    }
                }
            }
            .contentMargins(.horizontal, .spacingM, for: .scrollContent)
        }
    }
}

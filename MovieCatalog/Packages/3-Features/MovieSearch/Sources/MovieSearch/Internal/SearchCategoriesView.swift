import MovieComponents
import Navigation
import SwiftUI

struct SearchCategoriesView: View {
    let genres: [GenreViewData]

    private let columns: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(genres) { genre in
                    NavigationButton(push: genre.destination) {
                        CustomAsyncImage(state: genre.image, transform: { image in
                            image
                                .resizable()
                                .scaledToFill()
                        })
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .overlay(
                            LinearGradient(
                                colors: [
                                    .clear,
                                    .black.opacity(0.6),
                                    .black.opacity(0.8),
                                ],
                                startPoint: .init(x: 0, y: 0.5),
                                endPoint: .init(x: 0, y: 1)
                            )
                        )
                        .overlay(alignment: .bottomTrailing) {
                            Text(genre.name)
                                .font(.headline)
                                .padding(.spacingS)
                                .shadow(radius: 2)
                        }
                        .clipShape(.rect(cornerRadius: 8))
                    }
                    .tint(Color.white)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        SearchCategoriesView(genres: GenreViewData.sampleCollection)
            .navigationTitle("Genres")
    }
    .environment(Router.previewRouter())
}

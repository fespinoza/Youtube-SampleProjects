import MovieComponents
import Navigation
import SwiftUI

struct MovieDetailsView: View {
    let viewData: MovieDetailsViewData

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: .spacingL) {
                CustomAsyncImage(state: viewData.poster) { image in
                    image
                        .resizable()
                }
                .aspectRatio(4.0 / 6.0, contentMode: .fill)
                .frame(maxWidth: .infinity)
                .overlay { readableGradient }
                .overlay(alignment: .bottom) { content }
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

                ContentSection(title: "Details") {
                    Grid(verticalSpacing: .spacingSM) {
                        GridRow {
                            Text("Release Date")
                            Text(viewData.releaseDate)
                        }
                        .gridColumnAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        GridRow {
                            Text("Genres")
                            Text(viewData.genres.joined(separator: ", "))
                        }
                        .gridColumnAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, .spacingM)
                }

                if !viewData.galleryItems.isEmpty {
                    ContentSection(title: "Gallery") {
                        ScrollView(.horizontal) {
                            HStack(spacing: .spacingM) {
                                ForEach(Array(viewData.galleryItems.enumerated()), id: \.element.id) { index, item in
                                    NavigationButton(destination: viewData.galleryDestinationFactory(index)) {
                                        CustomAsyncImage(state: item.image) { image in
                                            image
                                                .resizable()
                                        }
                                        .aspectRatio(item.aspectRatio, contentMode: .fill)
                                        .frame(width: 320)
                                        .contentShape(Rectangle())
                                    }
                                }
                            }
                        }
                        .contentMargins(.horizontal, .spacingM, for: .automatic)
                    }
                }

                if !viewData.actors.isEmpty {
                    ContentSection(title: "Cast & Crew") {
                        ScrollView(.horizontal) {
                            HStack(alignment: .top, spacing: .spacingSM) {
                                ForEach(viewData.actors) { actor in
                                    NavigationButton(push: .actorDetails(id: actor.id)) {
                                        ActorCardView(viewData: actor)
                                    }
                                }
                            }
                        }
                        .contentMargins(.horizontal, .spacingM, for: .automatic)
                    }
                }
            }
            .padding(.bottom, .spacingXL)
        }
        .ignoresSafeArea(.all, edges: .top)
    }

    var readableGradient: some View {
        LinearGradient(
            stops: [
                .init(color: .clear, location: 0.6),
                .init(color: .black.opacity(0.4), location: 0.7),
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
                    Text(viewData.releaseYear)
                    Text(viewData.runtime)
                }
                .font(.caption.bold())
                .foregroundStyle(.secondary)
            }

            NavigationButton(
                sheet: .movieDescriptionValue(
                    id: viewData.id,
                    title: viewData.title,
                    description: viewData.description
                )
            ) {
                Text(viewData.description)
                    .lineLimit(3)
                    .contentShape(Rectangle())
                    .overlay(alignment: .bottomTrailing) {
                        Text("MORE")
                            .padding(.leading, .spacingXL)
                            .padding(.trailing, .spacingXS)
                            .padding(.top, .spacingXXS)
                            .fontWeight(.bold)
                            .background(
                                LinearGradient(
                                    colors: [
                                        .black.opacity(0.0),
                                        .black.opacity(0.8),
                                    ],
                                    startPoint: .init(x: 0, y: 0),
                                    endPoint: .init(x: 0.5, y: 0)
                                )
                                .blur(radius: 4)
                            )
                    }
                    .tint(.primary)
            }
        }
        .padding(.horizontal, .spacingM)
        .padding(.bottom, .spacingXL)
        .colorScheme(.dark)
    }

    struct ActorCardView: View {
        let viewData: MovieDetailsViewData.ActorViewData

        var body: some View {
            VStack {
                ProfilePictureView(image: viewData.profilePicture)

                Text(viewData.name)
                Text(viewData.characterName)
                    .foregroundStyle(Color.secondary)
            }
            .font(.caption)
            .tint(.primary)
            .frame(width: 100)
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailsView(viewData: .previewValue())
    }
}

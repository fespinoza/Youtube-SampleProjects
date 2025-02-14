import SwiftUI

struct MovieCardView: View {
    let viewData: MovieCardViewData

    @Environment(\.movieCardSize) var movieCardSize

    var body: some View {
        VStack(alignment: .leading) {
            CustomAsyncImage(state: viewData.image) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: movieCardSize.width, height: movieCardSize.height)
            .clipShape(.rect(cornerRadius: .cornerRadiusS))
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(.gray.opacity(0.5))
            )
            .clipped()
            .shadow(radius: 2)

            polymorphicContent
        }
        .frame(width: movieCardSize.width)
        .contentShape(Rectangle())
        .tint(.primary)
    }

    @ViewBuilder var polymorphicContent: some View {
        HStack(alignment: .top, spacing: .spacingXS) {
            if case let .ranking(ranking) = viewData.style {
                Text(ranking)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
            }

            Text(viewData.title)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
        }

        if case let .upcoming(releaseDate) = viewData.style {
            Text(releaseDate)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            HStack(alignment: .top) {
                MovieCardView(viewData: .previewValue())
                MovieCardView(viewData: .previewValue(style: .ranking(ranking: "#2")))
                MovieCardView(viewData: .previewValue(style: .upcoming(releaseDate: "July 4th")))
            }
            HStack(alignment: .top) {
                MovieCardView(viewData: .previewValue(
                    title: "Eternal Sunshine of the Spotless Mind",
                    image: .loading))
                MovieCardView(
                    viewData: .kindaPregnant()
                )
                MovieCardView(viewData: .eternalSunshine())
            }
            HStack(alignment: .top) {
                MovieCardView(viewData: .theApprentice())
                Spacer()
            }
        }
        .padding()
        .movieCardSize(.medium)
    }
}

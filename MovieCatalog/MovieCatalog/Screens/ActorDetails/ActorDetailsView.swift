import SwiftUI

struct ActorDetailsView: View {
    let viewData: ActorDetailsViewData

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: .spacingL) {
                header

                ContentSection(title: "Biography") {
                    Text(viewData.bio)
                        .padding(.horizontal, .spacingM)
                }

                ContentSection(title: "Movies") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: .spacingML) {
                            ForEach(viewData.movies) { movie in
                                NavigationLink(value: movie.id) {
                                    MovieCardView(viewData: movie)
                                }
                            }
                        }
                    }
                    .contentMargins(.horizontal, .spacingM, for: .scrollContent)
                }
            }
        }
    }

    var header: some View {
        HStack(alignment: .top, spacing: .spacingSM) {
            CustomAsyncImage(state: viewData.profilePicture) { image in
                image
                    .resizable()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 170)
            .clipShape(.rect(cornerRadius: .cornerRadiusS))

            VStack(alignment: .leading, spacing: .spacingXS) {
                Text(viewData.name)
                    .font(.title.bold())
                Text("Actor")
                    .foregroundStyle(Color.secondary)
            }

            Spacer()
        }
        .padding(.horizontal, .spacingM)
    }
}

#Preview {
    NavigationStack {
        ActorDetailsView(viewData: .previewValue())
    }
}

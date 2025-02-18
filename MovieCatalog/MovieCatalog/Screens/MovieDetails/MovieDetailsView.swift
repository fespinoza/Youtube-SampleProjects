import SwiftUI

struct MovieViewData {
    let poster: Image

    let title: String

    let releaseYear: String
    let duration: String

    let summary: String

    let releaseDate: String
    let genres: String

    let galleryItems: [Image]

    let actors: [Actor]

    struct Actor {
        let profileImage: Image
        let name: String
        let character: String
    }
}

struct MovieDetailsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .spacingL) {
                Image(.Movie.IronMan.medium)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 600)
                    .clipped()
                    .overlay {
                        LinearGradient(
                            colors: [
                                .clear,
                                .black,
                            ],
                            startPoint: .init(x: 0, y: 0.55),
                            endPoint: .init(x: 0, y: 1.0)
                        )
                    }
                    .overlay(alignment: .bottom) {
                        VStack(spacing: .spacingS) {
                            Text("Iron Man")
                                .font(.title.bold())
                            
                            HStack {
                                Text("2008")
                                Text("2h 6m")
                            }
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            
                            Text("After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.")
                                .padding(.horizontal, .spacingM)
                            
                        }
                        .padding(.bottom, .spacingS)
                        .colorScheme(.dark)
                    }
                
                VStack(alignment: .leading) {
                    Text("Details")
                        .font(.title2.bold())
                        .padding(.bottom, .spacingS)
                    
                    Grid(verticalSpacing: .spacingSM) {
                        GridRow {
                            Text("Release Date")
                            Text("May 30th, 2008")
                        }
                        .gridColumnAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        GridRow {
                            Text("Genres")
                            Text("Action, Science Fiction, Adventure")
                        }
                        .gridColumnAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal, .spacingM)
                
                VStack(alignment: .leading) {
                    Text("Gallery")
                        .font(.title2.bold())
                        .padding(.bottom, .spacingS)
                        .padding(.horizontal, .spacingM)

                    ScrollView(.horizontal) {
                        HStack(spacing: .spacingM) {
                            Image(.Gallery.IronMan.image1)
                                .resizable()
                                .aspectRatio(1.7, contentMode: .fill)
                                .frame(width: 320)

                            Image(.Gallery.IronMan.image2)
                                .resizable()
                                .aspectRatio(1.7, contentMode: .fill)
                                .frame(width: 320)

                            Image(.Gallery.IronMan.image3)
                                .resizable()
                                .aspectRatio(1.7, contentMode: .fill)
                                .frame(width: 320)
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .contentMargins(.horizontal, .spacingM, for: .automatic)
                }
                
                VStack(alignment: .leading) {
                    Text("Cast & Crew")
                        .font(.title2.bold())
                        .padding(.bottom, .spacingS)
                        .padding(.horizontal, .spacingM)

                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: .spacingSM) {
                            VStack {
                                Image(.Actor.PedroPascal.medium)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(.rect(cornerRadius: .cornerRadiusS))
                                    .clipped()

                                Text("Robert Downey Jr.")
                                Text("Tony Stark")
                                    .foregroundStyle(Color.secondary)
                            }
                            .font(.caption)
                            .tint(.primary)
                            .frame(width: 100)

                            VStack {
                                Image(.Actor.PedroPascal.medium)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(.rect(cornerRadius: .cornerRadiusS))
                                    .clipped()

                                Text("Robert Downey Jr.")
                                Text("Tony Stark")
                                    .foregroundStyle(Color.secondary)
                            }
                            .font(.caption)
                            .tint(.primary)
                            .frame(width: 100)
                        }
                    }
                    .contentMargins(.horizontal, .spacingM, for: .automatic)
                }
            }
        }
    }
}

#Preview {
    MovieDetailsView()
}

extension MovieViewData {
    static func previewValue(
        poster: Image = Image(.Movie.IronMan.medium),
        title: String = "Iron Man",
        releaseYear: String = "2008",
        duration: String = "2h 6m",
        summary: String = "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.",
        releaseDate: String = "October 30th, 2024",
        genres: String = "Action, Science Fiction, Adventure",
        galleryItems: [Image] = [Image(.Gallery.IronMan.image1), Image(.Gallery.IronMan.image2), Image(.Gallery.IronMan.image3)],
        actors: [MovieViewData.Actor] = [.previewValue(), .previewValue()]
    ) -> Self {
        .init(
            poster: poster,    
            title: title,    
            releaseYear: releaseYear,    
            duration: duration,    
            summary: summary,    
            releaseDate: releaseDate,    
            genres: genres,
            galleryItems: galleryItems,
            actors: actors
        )
    }
}
extension MovieViewData.Actor {
    static func previewValue(
        profileImage: Image = Image(.Actor.PedroPascal.medium),
        name: String = "Robert Downey Jr.",
        character: String = "Iron Man"
    ) -> Self {
        .init(
            profileImage: profileImage,    
            name: name,    
            character: character   
        )
    }
}

import SwiftUI

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
                                Text("Action")
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

import SwiftUI

struct RootContainer: View {
    @State var genreStore: GenreStore = .init()

    var body: some View {
        TabView {
            NavigationStack {
                HomeScreen()
                    .navigationDestination(for: ActorID.self) { actorID in
                        ActorDetailsScreen(actorID: actorID)
                    }
                    .navigationDestination(for: MovieListType.self) { listType in
                        MovieListScreen(listType: listType)
                    }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            TodoScreen(title: "Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            NavigationStack {
                ReleaseCalendarScreen()
                    .navigationDestination(for: ActorID.self) { actorID in
                        ActorDetailsScreen(actorID: actorID)
                    }
                    .navigationDestination(for: MovieListType.self) { listType in
                        MovieListScreen(listType: listType)
                    }
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Release Calendar")
            }

            TodoScreen(title: "Favorites")
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
        .environment(genreStore)
    }
}

#Preview {
    RootContainer()
}

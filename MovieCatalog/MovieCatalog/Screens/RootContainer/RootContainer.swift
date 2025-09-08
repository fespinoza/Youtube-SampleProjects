import SwiftUI
import Navigation
import MovieSearch

struct RootContainer: View {
    @State var genreStore: GenreStore = .init()
    @State var router: Router = .init(level: 0, identifierTab: nil)

    var body: some View {
        TabView(selection: $router.selectedTab) {
            Tab("Home", systemImage: "house", value: TabDestination.home) {
                NavigationContainer(parentRouter: router, tab: .home) {
                    HomeScreen()
                }
            }

            Tab("Releases", systemImage: "calendar", value: TabDestination.releaseCalendar) {
                NavigationContainer(parentRouter: router, tab: .releaseCalendar) {
                    ReleaseCalendarScreen()
                }
            }

            Tab("Favorites", systemImage: "star", value: TabDestination.favorites) {
                NavigationContainer(parentRouter: router, tab: .favorites) {
                    TodoScreen(title: "Favorites")
                }
            }

            Tab("Search", systemImage: "magnifyingglass", value: TabDestination.search, role: .search) {
                NavigationContainer(parentRouter: router, tab: .search) {
                    MovieSearchScreen()
                }
            }
        }
        .environment(genreStore)
    }
}

#Preview {
    RootContainer()
}

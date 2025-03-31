import Foundation
import MovieModels

enum Destination: Hashable {
    case tab(_ destination: TabDestination)
    case push(_ destination: PushDestination)
    case sheet(_ destination: SheetDestination)
    case fullScreen(_ destination: FullScreenDestination)
}

extension Destination: CustomStringConvertible {
    var description: String {
        switch self {
        case let .tab(destination): ".tab(\(destination))"
        case let .push(destination): ".push(\(destination))"
        case let .sheet(destination): ".sheet(\(destination))"
        case let .fullScreen(destination): ".fullScreen(\(destination))"
        }
    }
}

enum PushDestination: Hashable, CustomStringConvertible {
    case movieDetails(id: MovieID)
    case actorDetails(id: ActorID)
    case movieList(_ movieListType: MovieListType)

    var description: String {
        switch self {
        case let .movieDetails(id): ".movieDetails(\(id))"
        case let .actorDetails(id): ".actorDetails(\(id))"
        case let .movieList(type): ".movieList(\(type))"
        }
    }
}

enum TabDestination: String, Hashable {
    case home
    case search
    case releaseCalendar
    case favorites
}

enum SheetDestination: Hashable, CustomStringConvertible {
    case movieDescription(id: MovieID)
    case movieDescriptionValue(id: MovieID, title: String, description: String)

    var description: String {
        switch self {
        case let .movieDescription(id): ".movieDescription(\(id))"
        case let .movieDescriptionValue(id, _, _): ".movieDescriptionValue(\(id))"
        }
    }
}

extension SheetDestination: Identifiable {
    var id: String {
        switch self {
        case let .movieDescription(id): id.rawValue.formatted()
        case let .movieDescriptionValue(id, _, _): id.rawValue.formatted()
        }
    }
}

enum FullScreenDestination: Hashable {
    // `movieGallery` and `movieGalleryValue` are the same, but they represent
    // different data states, for the first one, we need to fetch the data, but
    // on the second one the data is already available.
    //
    // The first one is intended for deep linking
    // The second one is intended for in-app navigation, as the data is already available
    // when we will show the movie gallery
    case movieGallery(id: MovieID)
    case movieGalleryValue(id: MovieID, images: [ImageContainerViewData], selectedImageIndex: Int)
}

extension FullScreenDestination: CustomStringConvertible {
    var description: String {
        switch self {
        case let .movieGallery(id): ".movieGallery(\(id))"
        case let .movieGalleryValue(id, _, _): ".movieGalleryValue(\(id))"
        }
    }
}

extension FullScreenDestination: Identifiable {
    var id: String {
        switch self {
        case let .movieGallery(id): id.rawValue.formatted()
        case let .movieGalleryValue(id, _, _): id.rawValue.formatted()
        }
    }
}

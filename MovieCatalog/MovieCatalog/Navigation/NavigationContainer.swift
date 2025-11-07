import SwiftUI
import Config
import Navigation

/// ``NavigationStack`` container that works with the ``Router``
/// to resolve the routes based on the ``Router``'s state
struct NavigationContainer<Content: View>: View {
    // The navigation container itself it's in charge of the lifecycle
    // of the router.
    @State var router: Router
    @ViewBuilder var content: () -> Content

    init(
        parentRouter: Router,
        tab: TabDestination? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._router = .init(initialValue: parentRouter.childRouter(for: tab))
        self.content = content
    }

    var body: some View {
        InnerContainer(router: router) {
            content()
        }
        .environment(router)
        .onAppear(perform: router.setActive)
        .onDisappear(perform: router.resignActive)
        .onOpenURL(perform: openDeepLinkIfFound(for:))
    }

    func openDeepLinkIfFound(for url: URL) {
        if let destination = DeepLink.destination(from: url) {
            router.deepLinkOpen(to: destination)
        } else {
            router.logger.warning("No destination matches \(url)")
        }
    }
}

// This is necessary for getting a binder from an Environment Observable object
private struct InnerContainer<Content: View>: View {
    @Bindable var router: Router
    @ViewBuilder var content: () -> Content

    var body: some View {
        NavigationStack(path: $router.navigationStackPath) {
            content()
                .navigationDestination(for: PushDestination.self) { destination in
                    view(for: destination)
                }
        }
        // it's important that the these modifiers are **outside** the `NavigationStack`
        // otherwise the content closure will be called infinitely freezing the app
        .sheet(item: $router.presentingSheet) { sheet in
            navigationView(for: sheet, from: router)
        }
        .fullScreenCover(item: $router.presentingFullScreen) { fullScreen in
            navigationView(for: fullScreen, from: router)
        }
    }

    @ViewBuilder func navigationView(for destination: SheetDestination, from router: Router) -> some View {
        NavigationContainer(parentRouter: router) { view(for: destination) }
    }

    @ViewBuilder func navigationView(for destination: FullScreenDestination, from router: Router) -> some View {
        NavigationContainer(parentRouter: router) { view(for: destination) }
    }
}

#Preview {
    NavigationContainer(parentRouter: .previewRouter()) {
        Text("Hello")
    }
}

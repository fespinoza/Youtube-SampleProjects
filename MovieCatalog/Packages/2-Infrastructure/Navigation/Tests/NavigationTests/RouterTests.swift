import Foundation
import MovieModels
@testable import Navigation
import Testing

@Suite("Router Tests")
struct RouterTests {
    @Test("Creating a child router")
    func createingChildRouter() {
        // given
        let router = Router(level: 0, identifierTab: .home)

        // when
        let child = router.childRouter()

        // then
        #expect(child.level == router.level + 1)
        #expect(child.identifierTab == .home)
    }

    @Test("Setting the child router as active")
    func setChildRouterAsActive() {
        // given
        let router = Router(level: 0, identifierTab: .home)
        router.setActive()
        let child = router.childRouter()

        // when
        child.setActive()

        // then
        #expect(!router.isActive)
        #expect(child.isActive)
    }

    @Test("Selecting a tab reset the leaf router content")
    func selectingATabResetTheLeafRouter() {
        // given
        let router = Router(level: 0, identifierTab: nil)
        let child = router.childRouter(for: .home)
        child.push(.movieDetails(id: .randomPreviewId()))

        // when
        child.select(tab: .home)

        // then
        #expect(router.selectedTab == .home)
        #expect(child.navigationStackPath.isEmpty)
    }

    @Test("Opening a deep link doens't work on non active routers")
    func openingADeepLinkOnNonActiveRouter() {
        // given
        let router = Router(level: 0, identifierTab: nil)
        let home = router.childRouter(for: .home)
        home.setActive()

        // when
        router.deepLinkOpen(to: .push(.actorDetails(id: .randomPreviewId())))

        // then
        #expect(router.navigationStackPath.isEmpty)
    }

    @Test("Opening a deep link works on an active router")
    func openingADeepLinkOnActiveRouter() {
        // given
        let router = Router(level: 0, identifierTab: nil)
        let home = router.childRouter(for: .home)
        home.setActive()
        let actorID = ActorID.randomPreviewId()

        // when
        home.deepLinkOpen(to: .push(.actorDetails(id: actorID)))

        // then
        #expect(home.navigationStackPath == [.actorDetails(id: actorID)])
    }
}

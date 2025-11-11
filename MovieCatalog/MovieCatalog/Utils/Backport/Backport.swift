import SwiftUI

// taken from https://davedelong.com/blog/2021/10/09/simplifying-backwards-compatibility-in-swift/

struct Backport<Content> {
    let content: Content
}

extension View {
    var backport: Backport<Self> { Backport(content: self) }
}

extension Backport {
    enum TabBarMinimizeBehavior {
        case automatic
        case onScrollDown
        case onScrollUp
        case never

        /// Bridging back to the SwiftUI version
        @available(iOS 26.0, *)
        var systemVersion: SwiftUI.TabBarMinimizeBehavior {
            switch self {
            case .automatic: .automatic
            case .onScrollDown: .onScrollDown
            case .onScrollUp: .onScrollUp
            case .never: .never
            }
        }
    }
}

extension Backport where Content: View {
    @ViewBuilder func tabBarMinimizeBehavior(_ behavior: Backport.TabBarMinimizeBehavior) -> some View {
        if #available(iOS 26, *) {
            content.tabBarMinimizeBehavior(behavior.systemVersion)
        } else {
            content
        }
    }
}

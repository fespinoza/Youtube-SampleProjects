import SwiftUI

public extension EnvironmentValues {
    @Entry var isDebugColorEnabled: Bool = false
    @Entry var debugColorLevel: Int?
    @Entry var debugColorOpacity: Double = 0.2
}

public extension View {
    func debugColorEnabled(_ enable: Bool = true) -> some View {
        environment(\.isDebugColorEnabled, enable)
    }

    func debugColorOpacity(_ opacity: Double = 0.2) -> some View {
        environment(\.debugColorOpacity, opacity)
    }

    func debugColorLevel(_ level: Int) -> some View {
        environment(\.isDebugColorEnabled, true)
            .environment(\.debugColorLevel, level)
    }

    func debugColorAllLevels() -> some View {
        environment(\.isDebugColorEnabled, true)
            .environment(\.debugColorLevel, nil)
    }

    func debugBackground(_ color: Color = .blue, level: Int? = nil) -> some View {
        DebugColorView(color: color, debugTool: .background, level: level, content: { self })
    }

    func debugOverlay(_ color: Color = .red, level: Int? = nil) -> some View {
        DebugColorView(color: color, debugTool: .overlay, level: level, content: { self })
    }

    func debugBorder(_ color: Color = .green, showSize: Bool = false, level: Int? = nil) -> some View {
        DebugColorView(color: color, debugTool: .border(includeSize: showSize), level: level, content: { self })
    }

    func showSize() -> some View {
        SizeReader(content: { self })
    }
}

enum DebugColorCase {
    case background
    case overlay
    case border(includeSize: Bool)
}

struct DebugColorView<Content: View>: View {
    let color: Color
    let debugTool: DebugColorCase
    let level: Int?
    @Environment(\.isDebugColorEnabled) private var isDebugColorEnabled
    @Environment(\.debugColorOpacity) private var debugColorOpacity
    @Environment(\.debugColorLevel) private var debugColorLevel: Int?
    @ViewBuilder var content: Content

    var body: some View {
        if shouldShowDebugColor {
            switch debugTool {
            case .background:
                content.background(debugColor)
            case .overlay:
                content.overlay(debugColor)
            case let .border(includeSize) where includeSize:
                content
                    .showSize()
                    .border(color)
            case .border:
                content.border(color)
            }
        } else {
            content
        }
    }

    var shouldShowDebugColor: Bool {
        if let level, let debugColorLevel {
            isDebugColorEnabled && level >= debugColorLevel
        } else {
            isDebugColorEnabled
        }
    }

    private var debugColor: some View {
        color.opacity(debugColorOpacity)
    }
}

struct SizeReader<Content: View>: View {
    @State private var size: CGSize = .zero
    @ViewBuilder var content: Content

    var body: some View {
        content
            .background(
                GeometryReader(content: { proxy in
                    Color
                        .clear
                        .onAppear(perform: { size = proxy.size })
                })
            )
            .overlay {
                Text("w: \(size.width), h: \(size.height)")
                    .font(.caption)
                    .background(Color.blue)
            }
    }
}

import SwiftUI

struct BasicStateView<ViewData: Equatable, LoadingContent: View, DataContent: View>: View {
    @Binding var state: BasicLoadingState<ViewData>
    @ViewBuilder var loadingContent: () -> LoadingContent
    @ViewBuilder var dataContent: (ViewData) -> DataContent
    var fetchData: () async throws -> ViewData

    var body: some View {
        Group {
            switch state {
            case .idle,
                    .loading:
                loadingContent()
                    .disabled(true)
            case let .dataLoaded(viewData):
                dataContent(viewData)
            case let .error(error):
                ContentUnavailableView(
                    "Error",
                    systemImage: "xmark",
                    description: Text(error.localizedDescription)
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task { await initialLoad() }
    }

    func initialLoad() async {
        guard .idle == state else { return }
        await performFetchData()
    }

    private func performFetchData(showLoading: Bool = true) async {
        if showLoading { state = .loading }

        do {
            let viewData = try await fetchData()
            state = .dataLoaded(viewData)
        } catch {
            dump(error)
            state = .error(error)
        }
    }
}


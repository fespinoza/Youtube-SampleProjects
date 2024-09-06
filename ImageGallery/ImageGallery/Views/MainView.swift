import SwiftUI

@Observable
class MainViewModel {
    var folders: [Folder] = []
    var selectedFolder: Folder?

    init(folders: [Folder] = []) {
        self.folders = folders
        self.selectedFolder = folders.first
    }
}

struct MainView: View {
    @Bindable var viewModel: MainViewModel

    var body: some View {
        NavigationSplitView {
            List(viewModel.folders, selection: $viewModel.selectedFolder) { folder in
                NavigationLink(value: folder) {
                    Text(folder.name)
                }
            }
        } detail: {
            if let selectedFolder = viewModel.selectedFolder {
                ImageGrid(folder: selectedFolder)
                    .navigationTitle(selectedFolder.name)
            } else {
                Text("Start by importing and selecting a folder")
            }
        }
    }
}

#Preview {
    MainView(
        viewModel: .init(
            folders: [
                .testValue(name: "Test #1"),
                .testValue(name: "Test #2"),
                .testValue(name: "Test #3"),
            ]
        )
    )
}

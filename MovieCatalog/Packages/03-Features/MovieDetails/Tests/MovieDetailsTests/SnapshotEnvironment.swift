import SwiftUI
import SnapshotTesting
import SnapshotTestingKit

class SnapshotEnvironment: SnapshotRunningEnvironment {
    func sourceCodeTestDirectory() -> URL {
        URL(fileURLWithPath: "\(#file)", isDirectory: false)
            .deletingPathExtension()
            .deletingLastPathComponent()
    }

    func bundleUrl() -> URL {
        guard let url = Bundle.module.resourceURL else {
            fatalError("Could not find bundle URL")
        }
        return url
    }
}

func expectSnapshot(
    of view: some View,
    on variant: SnapshotVariant,
    record: SnapshotTestingConfiguration.Record = .missing,
    fileID: StaticString = #fileID,
    file filePath: StaticString = #filePath,
    testName: String = #function,
    line: UInt = #line,
    column: UInt = #column
) {
    SnapshotEnvironment().expectSnapshot(
        of: view,
        on: variant,
        record: record,
        fileID: fileID,
        file: filePath,
        testName: testName,
        line: line,
        column: column
    )
}

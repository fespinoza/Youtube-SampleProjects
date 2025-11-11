import Foundation
import SnapshotTesting
import SwiftUI
import Testing
import XCTest

/// Requirements to correctly set up a target or package to run snapshot tests
/// that can work both locally and on CI
public protocol SnapshotRunningEnvironment {
    /// Location where the source code is found
    /// to run the snapshots against this location locally
    ///
    /// > [!WARNING]
    /// > The implementation of `sourceCodeTestDirectory` depends on the location in the
    /// > file system of the type that confirms
    /// > to `SnapshotRunningEnvironment` and if the location changes, the implementation may need to change as well
    func sourceCodeTestDirectory() -> URL

    /// Location of the bundle, so the snapshots can be
    /// run in CI pointing to the bundle location
    func bundleUrl() -> URL
}

public extension SnapshotRunningEnvironment {
    var isSnapshotTestingEnabledForEnvironment: Bool {
        ProcessInfo.processInfo.environment["SNAPSHOT_TESTING_ENABLED"]?.lowercased() == "true"
    }

    var isRunningOnCI: Bool {
        ProcessInfo.processInfo.environment["SNAPSHOT_ON_CI"]?.lowercased() == "true"
    }

    /// the base url where the snapshots will be found
    var snapshotsTestBaseUrl: URL {
        isRunningOnCI ? bundleUrl() : sourceCodeTestDirectory()
    }

    var defaultRecordMode: SnapshotTestingConfiguration.Record {
        isRunningOnCI ? .never : .missing
    }
}

extension SnapshotRunningEnvironment {
    /// Custom implementation of `assertSnapshot` that allow us to configure the snapshot directory
    /// plus normalize the configurations on how the snapshots are taken for the SATS app and its modules
    ///
    /// - Parameters:
    ///   - view: the view to test
    ///   - variant: configuration of whcih device and configurations the snapshot will be taken in
    ///   - record: (default `nil`) optional override to the record mode
    public func expectSnapshot(
        of view: some View,
        on variant: SnapshotVariant,
        record: SnapshotTestingConfiguration.Record? = nil,
        fileID: StaticString = #fileID,
        file filePath: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line,
        column: UInt = #column
    ) {
        let testClassName = URL(fileURLWithPath: "\(filePath)", isDirectory: false)
            .deletingPathExtension()
            .lastPathComponent

        let snapshotDirectory = snapshotsTestBaseUrl.appending(path: "__Snapshots__/\(testClassName)").path()

        withSnapshotTesting(record: record ?? defaultRecordMode) {
            let failure = SnapshotTesting.verifySnapshot(
                of: TestContainerView(variant: variant, content: { view }),
                as: .image(
                    drawHierarchyInKeyWindow: variant.drawHierarchyInKeyWindow,
                    precision: variant.precision,
                    perceptualPrecision: variant.perceptualPrecision,
                    layout: variant.layout,
                    traits: variant.device.deviceTraits
                ),
                named: variant.fileName,
                snapshotDirectory: snapshotDirectory,
                fileID: fileID,
                file: filePath,
                testName: testName,
                line: line,
                column: column
            )
            guard let message = failure else { return }
            recordIssue(
                message,
                fileID: fileID,
                filePath: filePath,
                line: line,
                column: column
            )
        }
    }

    private func recordIssue(
        _ message: @autoclosure () -> String,
        fileID: StaticString,
        filePath: StaticString,
        line: UInt,
        column: UInt
    ) {
        #if canImport(Testing)
            if Test.current != nil {
                Issue.record(
                    Comment(rawValue: message()),
                    sourceLocation: SourceLocation(
                        fileID: fileID.description,
                        filePath: filePath.description,
                        line: Int(line),
                        column: Int(column)
                    )
                )
            } else {
                XCTFail(message(), file: filePath, line: line)
            }
        #else
            XCTFail(message(), file: filePath, line: line)
        #endif
    }
}

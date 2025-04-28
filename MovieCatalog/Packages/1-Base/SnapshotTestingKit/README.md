# SnapshotTestingKit

Utilities to use snapshot testing in apps and its modules.

## Installation

### SPM Depedency

After adding the dependency in the SPM `Package.swift`, set the dependency to the target like:

```swift
.testTarget(
    name: "MyModuleTests",
    dependencies: ["MyModule", "SnapshotTestingKit"],
    resources: [
        // important to work on CI
        .copy("__Snapshots__"),
    ]
),
```

Then, In your `MyModuleTests` target, you need to make sure to have an implementation of `SnapshotRunningEnvironment`:

```swift
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
    record: SnapshotTestingConfiguration.Record? = nil,
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
```

### iOS target

The implementation of `SnapshotRunningEnvironment` maybe different, mostly since the `bundleUrl` needs to be different.

> [!WARNING]  
> The implementation of `sourceCodeTestDirectory` depends on the location in the file system of the type that confirms
> to `SnapshotRunningEnvironment` and if the location changes, the implementation may need to change as well 

## Usage

Then in Tests or XCTests, you can just call

```swift
expectSnapshot(of: view, on: .iPhone(.dark))
```

For Swift Testing, you can also use parameterized variants like:

```swift
@MainActor
@Test(
    "Sample Test",
    arguments: SnapshotVariant.defaultVariants()
)
func testMyView(_ variant: SnapshotVariant) async throws {
    let view = MyView()

    expectSnapshot(of: view, on: variant)
}
```

You can check ``SnapshotVariant.defaultVariants()`` or ``SnapshotVariant.minimalVariants()`` methods.

// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "taskwarrior",
    products: [
        .library(name: "taskwarrior", targets: ["task", "lex", "calc"])
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "task",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/task.xcframework.zip",
            checksum: "15f7aa56150014e36ba851d40c178613443ee0926e6d37d7cb4136c86113a742"
        ),
        .binaryTarget(
            name: "lex",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/lex.xcframework.zip",
            checksum: "f19f1f95ea27f6bdca2196e0647fccd801dad84f942d63ed2c430b46b8a66406"
        ),
        .binaryTarget(
            name: "calc",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/calc.xcframework.zip",
            checksum: "a57efcd637558891e72469fd91355a3a47adbe8435c926ef722591317878e608"
        )
    ]
)

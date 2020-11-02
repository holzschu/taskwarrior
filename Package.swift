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
            checksum: "f0735ab4f8fc9097a698ef4ce5bc21b576ce1d48cbf90065c0282c116822c3a0"
        ),
        .binaryTarget(
            name: "lex",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/lex.xcframework.zip",
            checksum: "da54b849f899f4aaefe68ef75235e1889d008c5bc681d589c1ef3cf41b81e48a"
        ),
        .binaryTarget(
            name: "calc",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/calc.xcframework.zip",
            checksum: "b7cce32af48f581d0c13d43d7c2e9e1b48fd0bd8a2efd0198f0f091a5c441b99"
        )
    ]
)

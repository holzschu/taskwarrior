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
            checksum: "ac6589d1e90ed5eb2a969d50a618f9c92da2a74305ef9f6caa2d8b4d36837b70"
        ),
        .binaryTarget(
            name: "lex",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/lex.xcframework.zip",
            checksum: "08916648891bd2070e61c0c202dcd6eed1840981ffd6dc38ffd940b03e31939b"
        ),
        .binaryTarget(
            name: "calc",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/calc.xcframework.zip",
            checksum: "4732b1eaad5f9060faaea73b33e43fb5d59af884b3eff678df27e2abb9b98cf0"
        )
    ]
)

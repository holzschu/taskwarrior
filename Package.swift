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
            checksum: "5b34c303e705caa3d2166ea908c4d970a8429803988643559a9a6c0d446d4261"
        ),
        .binaryTarget(
            name: "lex",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/lex.xcframework.zip",
            checksum: "528e91f86e30f95ba1acc658e46ddc9d54a1ab37dbf81f29706d76c7af93e0bd"
        ),
        .binaryTarget(
            name: "calc",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/calc.xcframework.zip",
            checksum: "2b44125afc21bf51ea38c3b276c7a4f7489ca8eb1abe1879a9a170a1d47f91ab"
        )
    ]
)

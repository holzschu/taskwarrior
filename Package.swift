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
            checksum: "8082f26ab6d1c994532c0cba4bd262e1d2415868d46bb511a566a7b788d6ec50"
        ),
        .binaryTarget(
            name: "lex",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/lex.xcframework.zip",
            checksum: "d816952e7cfd67f39e57693b21cc52016fcc79f96a1f58e118dcd88c2f52f8d1"
        ),
        .binaryTarget(
            name: "calc",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/calc.xcframework.zip",
            checksum: "65964fd9946d63a65cf14443276ed1518380b7cc97b1feb5d40ffd91e601bf61"
        )
    ]
)

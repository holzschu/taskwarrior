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
            checksum: "3fcc3b3fdd9e9247f9b08c1140343e790d38070e02a0a79edff43eb148abf043"
        ),
        .binaryTarget(
            name: "lex",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/lex.xcframework.zip",
            checksum: "d4a8e9d7519e4120ea12c18b50f652f3c8188d21c6cc066adf716869c159ad8b"
        ),
        .binaryTarget(
            name: "calc",
            url: "https://github.com/holzschu/taskwarrior/releases/download/1.0/calc.xcframework.zip",
            checksum: "1fba531bbea928b983e3d72d786bf6ca0a6ca5de043357738a3fb0a4ce1233e9"
        )
    ]
)

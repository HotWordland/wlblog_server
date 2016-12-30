import PackageDescription

let package = Package(
    name: "wlblog",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 3),
        .Package(url:"https://github.com/siemensikkema/vapor-jwt.git", majorVersion: 0, minor: 6),
        .Package(url:"https://github.com/vapor/postgresql-provider.git",majorVersion:1,minor:0)

    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)


// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IosAwnFcmCore",
    platforms: [
        // Firebase 12+ raised its minimum deployment target to iOS 15.
        .iOS(.v15)
    ],
    products: [
        .library(name: "IosAwnFcmCore", targets: ["IosAwnFcmCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/rafaelsetragni/IosAwnCore.git", from: "0.12.1"),
        // Allow Firebase iOS SDK 12.x (firebase_core 4 / CocoaPods) and 13.x
        // (firebase_core 5 / SwiftPM). `from: "12.0.0"` is 12.0.0..<13.0.0 only.
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", "12.0.0"..<"14.0.0"),
    ],
    targets: [
        .target(
            name: "IosAwnFcmCore",
            dependencies: [
                .product(name: "IosAwnCore", package: "IosAwnCore"),
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
            ],
            // Reuse the existing CocoaPods source tree so the same files feed both
            // Swift Package Manager and the IosAwnFcmCore.podspec during the transition.
            path: "IosAwnFcmCore/Classes"
        )
    ]
)

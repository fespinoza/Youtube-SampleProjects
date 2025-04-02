// The Swift Programming Language
// https://docs.swift.org/swift-book

//public struct Gallery {
//
//    public struct IronMan {
//
//    }
//
//
//
//}

//enum PreviewImage: String {
//    case actor
//}


public struct PreviewImage: ExpressibleByStringLiteral, Sendable {
    let rawValue: String

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value.description
    }
}

public extension PreviewImage {
    struct Actor {
        public struct BradPitt {
            public static let medium: PreviewImage = "actor/bradPitt/medium"
            public static let small: PreviewImage = "actor/bradPitt/small"
        }

        public struct PedroPascal {
            public static let medium: PreviewImage = "actor/pedroPascal/medium"
        }
    }

    struct Gallery {
        public struct IronMan {
            public static let image1: PreviewImage = "gallery/ironMan/image1"
            public static let image2: PreviewImage = "gallery/ironMan/image2"
            public static let image3: PreviewImage = "gallery/ironMan/image3"
            public static let image4: PreviewImage = "gallery/ironMan/image4"
        }
    }

    struct Movie {
        public struct EternalSunshine {
            public static let large: PreviewImage = "movie/eternalSunshine/large"
            public static let medium: PreviewImage = "movie/eternalSunshine/medium"
            public static let small: PreviewImage = "movie/eternalSunshine/small"
        }

        public struct Gladiator {
            public static let large: PreviewImage = "movie/gladiator/large"
            public static let medium: PreviewImage = "movie/gladiator/medium"
            public static let small: PreviewImage = "movie/gladiator/small"
        }

        public struct IronMan {
            public static let large: PreviewImage = "movie/ironMan/large"
            public static let medium: PreviewImage = "movie/ironMan/medium"
            public static let small: PreviewImage = "movie/ironMan/small"
        }

        public struct KindaPregnant {
            public static let large: PreviewImage = "movie/kindaPregnant/large"
            public static let medium: PreviewImage = "movie/kindaPregnant/medium"
            public static let small: PreviewImage = "movie/kindaPregnant/small"
        }
    }
}

import SwiftUI

public extension Image {
    init(preview: PreviewImage) {
        self.init(preview.rawValue, bundle: .module)
    }
}


func foo() {
    let a = Image(preview: .Actor.BradPitt.medium)
}

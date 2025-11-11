// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

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
        public struct Poster {
            public struct EternalSunshine {
                public static let large: PreviewImage = "movie/eternalSunshine/poster/large"
                public static let medium: PreviewImage = "movie/eternalSunshine/poster/medium"
                public static let small: PreviewImage = "movie/eternalSunshine/poster/small"
            }

            public struct Gladiator {
                public static let large: PreviewImage = "movie/gladiator/poster/large"
                public static let medium: PreviewImage = "movie/gladiator/poster/medium"
                public static let small: PreviewImage = "movie/gladiator/poster/small"
            }

            public struct IronMan {
                public static let large: PreviewImage = "movie/ironMan/poster/large"
                public static let medium: PreviewImage = "movie/ironMan/poster/medium"
                public static let small: PreviewImage = "movie/ironMan/poster/small"
            }

            public struct KindaPregnant {
                public static let large: PreviewImage = "movie/kindaPregnant/poster/large"
                public static let medium: PreviewImage = "movie/kindaPregnant/poster/medium"
                public static let small: PreviewImage = "movie/kindaPregnant/poster/small"
            }
        }

        public struct Backdrop {
            public struct IronMan {
                public static let large: PreviewImage = "movie/ironMan/backdrop/large"
                public static let medium: PreviewImage = "movie/ironMan/backdrop/medium"
                public static let small: PreviewImage = "movie/ironMan/backdrop/small"
            }
        }
    }
}

public extension Image {
    init(preview: PreviewImage) {
        self.init(preview.rawValue, bundle: .module)
    }
}

//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    extension NKMediaPlayerView {

        // Exposed

        // Type: NKMediaPlayerView
        // Topic: Size

        ///
        public struct Size {

            // Exposed

            // Type: NKMediaPlayerView.Size
            // Topic: Main

            ///
            public init(width: Width = .init(), height: Height = .init()) {
                self.width = width
                self.height = height
            }

            ///
            public var width: Width

            ///
            public var height: Height
        }
    }
#endif

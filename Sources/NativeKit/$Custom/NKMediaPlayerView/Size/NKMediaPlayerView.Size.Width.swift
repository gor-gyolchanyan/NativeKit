//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)

    extension NKMediaPlayerView.Size {

        // Exposed

        // Type: NKMediaPlayerView.Size
        // Topic: Width

        ///
        public enum Width {

            // Exposed

            // Type: NKMediaPlayerView.Size.Width
            // Topic: Main

            ///
            case tiny

            ///
            case small

            ///
            case regular

            ///
            case large
        }
    }

    extension NKMediaPlayerView.Size.Width {

        // Exposed

        // Type: NKMediaPlayerView.Size.Width
        // Topic: Main

        ///
        public init() {
            self = .regular
        }
    }
#endif

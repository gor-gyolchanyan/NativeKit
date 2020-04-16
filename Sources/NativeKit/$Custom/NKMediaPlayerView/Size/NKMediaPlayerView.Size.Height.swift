//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)

    extension NKMediaPlayerView.Size {

        // Exposed

        // Type: NKMediaPlayerView.Size
        // Topic: Height

        ///
        public enum Height {

            // Exposed

            // Type: NKMediaPlayerView.Size.Height
            // Topic: Main

            ///
            case regular

            ///
            case large
        }
    }

    extension NKMediaPlayerView.Size.Height {

        // Exposed

        // Type: NKMediaPlayerView.Size.Height
        // Topic: Main

        ///
        public init() {
            self = .regular
        }
    }
#endif

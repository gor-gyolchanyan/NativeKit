//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    import AVFoundation
    import AVKit

    // Exposed

    ///
    public final class NKMediaPlayerView<OuterViewController>: NKControllerView<OuterViewController, AVPlayerViewController>
    where OuterViewController: NKViewController {

        // Exposed

        // Class: NKMediaPlayerView
        // Topic: Main

        ///
        public init(_ size: Size = .init()) {
            self.size = size
            super.init()
            innerViewController = AVPlayerViewController()
        }

        ///
        public var size: Size {
            didSet {
                invalidateIntrinsicContentSize()
            }
        }

        ///
        public var mediaPlayer: AVPlayer? {
            get {
                innerViewController?.player
            }

            set(mediaPlayer) {
                innerViewController?.player = mediaPlayer
            }
        }

        // Class: NKView
        // Topic: Measuring In Auto Layout

        public override var intrinsicContentSize: NKSize {
            let width: NKFloat
            switch size.width {
                case .tiny:
                    width = 57
                case .small:
                    width = 113
                case .regular:
                    width = 222
                case .large:
                    width = 224
            }
            let height: NKFloat
            switch size.height {
                case .regular:
                    height = 43
                case .large:
                    height = 85
            }
            return .init(
                width: width,
                height: height
            )
        }
    }
#endif

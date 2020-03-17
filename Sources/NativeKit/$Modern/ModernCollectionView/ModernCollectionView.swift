//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: ModernCollectionView

open class ModernCollectionView: NativeCollectionView {

    // Class: NativeCollectionView

    // Exposed

    #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    public override convenience init(frame: CGRect, collectionViewLayout layout: NativeCollectionViewLayout) {
        self.init(frame: frame)
        if layout != self.collectionViewLayout {
            self.collectionViewLayout = layout
        }
    }
    #elseif os(macOS) && !targetEnvironment(macCatalyst)
    @available(OSX 10.11, *)
    public convenience init(frame: CGRect, collectionViewLayout layout: NativeCollectionViewLayout) {
        self.init(frame: frame)
        if layout != self.collectionViewLayout {
            self.collectionViewLayout = layout
        }
    }
    #endif

    // Class: NativeView

    // Exposed

    #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
        public convenience init(frame: CGRect) {
            self.init()
            if frame != self.frame {
                self.frame = frame
            }
        }
    #elseif os(macOS) && !targetEnvironment(macCatalyst)
        public override convenience init(frame: CGRect) {
            self.init()
            if frame != self.frame {
                self.frame = frame
            }
        }
    #endif

    // Class: NSObject

    // Exposed

    public init() {
        #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
            super.init(frame: .zero, collectionViewLayout: .init())
        #elseif os(macOS) && !targetEnvironment(macCatalyst)
            super.init(frame: .zero)
        #endif
    }

    // Protocol: NSCoding

    // Exposed

    @available(*, unavailable, message: "NSCoding conformance is disabled for this type")
    public required convenience init?(coder: NSCoder) {
        self.init()
    }

    @available(*, unavailable, message: "NSCoding conformance is disabled for this type")
    public final override func encode(with coder: NSCoder) { }
}

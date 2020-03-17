//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: ModernCollectionViewCell

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
open class ModernCollectionViewCell: NativeCollectionViewCell {

    // Class: NativeView

    // Exposed

    public override convenience init(frame: CGRect) {
        self.init()
        if frame != self.frame {
            self.frame = frame
        }
    }

    // Class: NSObject

    // Exposed

    public init() {
        super.init(frame: .zero)
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
#endif

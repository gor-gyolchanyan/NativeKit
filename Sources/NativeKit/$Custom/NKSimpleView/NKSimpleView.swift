//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS)
    import Foundation

    // Exposed

    ///
    open class NKSimpleView: NKView {

        // Exposed

        // Class: NKSimpleView
        // Topic: Main

        ///
        public init() {
            super.init(frame: .zero)
        }

        // Protocol: Foundation.NSCoding
        // Topic: Initializing With A Coder

        @available(*, unavailable, message: "Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
        public required convenience init?(coder: Foundation.NSCoder) {
            print("Suppressed an attempt to decode an object whose Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
            return nil
        }

        // Protocol: Foundation.NSCoding
        // Topic: Encoding With A Coder

        @available(*, unavailable, message: "Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
        public final override func encode(with coder: Foundation.NSCoder) {
            print("Suppressed an attempt to encode an object whose Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
        }
    }
#endif

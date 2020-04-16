//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS)
    import Foundation

    // Exposed

    ///
    open class NKSimpleViewController: NKViewController {

        // Exposed

        // Class: NKSimpleViewController
        // Topic: Main

        ///
        public init() {
            super.init(nibName: nil, bundle: nil)
        }

        // Class: NKViewController
        // Topic: Creating A View Controller

        @available(*, unavailable, message: "Support for NKNib and NKStoryboard is disabled for this type.")
        public override convenience init(nibName: String?, bundle: Foundation.Bundle?) {
            print("Suppressed an attempt to load from NKNib and NKStoryboard whose support for it is disabled for this type.")
            self.init()
        }

        // Class: NKViewController
        // Topic: Getting The Storyboard And Nib Information

        @available(*, unavailable, message: "Support for NKNib and NKStoryboard is disabled for this type.")
        public final override var storyboard: NKStoryboard? {
            print("Suppressed an attempt to use NKNib and NKStoryboard, the support for which it is disabled for this type.")
            return nil
        }

        @available(*, unavailable, message: "Support for NKNib and NKStoryboard is disabled for this type.")
        public final override var nibName: String? {
            print("Suppressed an attempt to use NKNib and NKStoryboard, the support for which it is disabled for this type.")
            return nil
        }

        @available(*, unavailable, message: "Support for NKNib and NKStoryboard is disabled for this type.")
        public final override var nibBundle: Foundation.Bundle? {
            print("Suppressed an attempt to use NKNib and NKStoryboard, the support for which it is disabled for this type.")
            return nil
        }

        // Class: NKViewController
        // Topic: Managing The View

        open override func loadView() {
            super.nkView = NKView()
        }

        // Protocol: Foundation.NSCoding
        // Topic: Initializing With A Coder

        @available(*, unavailable, message: "Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
        public required convenience init?(coder: NSCoder) {
            print("Suppressed an attempt to decode an object whose Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
            return nil
        }

        // Protocol: Foundation.NSCoding
        // Topic: Encoding With A Coder

        @available(*, unavailable, message: "Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
        public final override func encode(with coder: NSCoder) {
            print("Suppressed an attempt to encode an object whose Foundation.NSCoding conformance (and support for NKNib and NKStoryboard) is disabled for this type.")
        }
    }
#endif

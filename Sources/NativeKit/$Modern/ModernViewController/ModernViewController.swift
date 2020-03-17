//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: ModernViewController

open class ModernViewController: NativeViewController {

    // Class: NativeViewController
    // Topic: View

    // Exposed

    open override func loadView() {
        view = ModernView()
    }

    // Class: NativeViewController
    // Topic: NIB

    // Exposed

    @available(*, unavailable, message: "Support for NIB is disabled for this type")
    public override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init()
    }

    @available(*, unavailable, message: "Support for NIB is disabled for this type")
    open override var nibName: String? { nil }

    @available(*, unavailable, message: "Support for NIB is disabled for this type")
    open override var nibBundle: Bundle? { nil }

    // Class: NSObject

    // Exposed

    public init() {
        super.init(nibName: nil, bundle: nil)
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

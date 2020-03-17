//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    // Type: ModernNavigationController

    open class ModernNavigationController: NativeNavigationController {

        // Topic: Main

        // Exposed

        public init(
            navigationBarType: NativeNavigationBar.Type?,
            toolBarType: NativeToolBar.Type?
        ) {
            super.init(navigationBarClass: navigationBarType, toolbarClass: toolBarType)
        }

        // Class: NativeNavigationController

        // Exposed

        public override convenience init(rootViewController: NativeViewController) {
            self.init()
            pushViewController(rootViewController, animated: false)
        }

        @available(*, unavailable, renamed: "init(navigationBar:toolBar:)")
        public override convenience init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
            self.init(
                navigationBarType: navigationBarClass.map { $0 as? NativeNavigationBar.Type } ?? nil,
                toolBarType: toolbarClass.map { $0 as? NativeToolBar.Type } ?? nil
            )
        }

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

        public convenience init() {
            self.init(navigationBarType: nil, toolBarType: nil)
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

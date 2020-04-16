//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
    extension NKViewController {

        // Exposed

        // Type: NKResponder
        // Topic: Main

        ///
        public var nkView: NKView {
            get {
                view
            }

            set(nkView) {
                view = nkView
            }
        }

        ///
        public var viewIfLoaded: NKView? {
            isViewLoaded ? nkView : nil
        }
    }
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    extension NKViewController {

        // Exposed

        // Type: NKResponder
        // Topic: Main

        ///
        public var nkView: NKView {
            get {
                view!
            }

            set(nkView) {
                view = nkView
            }
        }
    }
#endif


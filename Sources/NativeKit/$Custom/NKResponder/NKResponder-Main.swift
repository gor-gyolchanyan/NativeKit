//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
    extension NKResponder {

        // Exposed

        // Type: NKResponder
        // Topic: Main

        ///
        public var nkNextResponder: NKResponder? {
            nextResponder
        }
    }
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    extension NKResponder {

        // Exposed

        // Type: NKResponder
        // Topic: Main

        ///
        public var nkNextResponder: NKResponder? {
            next
        }
    }
#endif

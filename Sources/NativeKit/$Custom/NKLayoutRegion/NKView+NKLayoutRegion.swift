//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS)
    import CoreGraphics

    extension NKView: NKLayoutRegion {

        // Exposed

        // Type: NKLayoutRegion
        // Topic: NKView

        public var regionIdentifier: String? { nil }

        public var regionFrame: CGRect { frame }

        public var regionView: NKView? { self }
    }
#endif

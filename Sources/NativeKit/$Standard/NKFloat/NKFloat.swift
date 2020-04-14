//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS)
    import CoreGraphics

    // Exposed

    ///
    public typealias NKFloat = CoreGraphics.CGFloat
#endif

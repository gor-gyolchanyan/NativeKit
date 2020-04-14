//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS)
    import CoreGraphics

    // Exposed

    public protocol NKLayoutRegion: AnyObject {

        // Exposed

        // Type: NKLayoutRegion
        // Topic: NKView

        var translatesAutoresizingMaskIntoConstraints: Bool { get set }
        var regionIdentifier: String? { get }
        var regionFrame: CGRect { get }
        var regionView: NKView? { get }

        // Type: NKLayoutRegion
        // Topic: Debugging

        var hasAmbiguousLayout: Bool { get }
        func constraintsAffectingLayout(for axis: NKLayoutOrientation) -> [NKLayoutConstraint]

        // Type: NKLayoutRegion
        // Topic: Horizontal

        var widthAnchor: NKLayoutDimension { get }
        var leftAnchor: NKLayoutXAxisAnchor { get }
        var rightAnchor: NKLayoutXAxisAnchor { get }
        var leadingAnchor: NKLayoutXAxisAnchor { get }
        var trailingAnchor: NKLayoutXAxisAnchor { get }

        // Type: NKLayoutRegion
        // Topic: Vertical

        var heightAnchor: NKLayoutDimension { get }
        var topAnchor: NKLayoutYAxisAnchor { get }
        var bottomAnchor: NKLayoutYAxisAnchor { get }
        var firstBaselineAnchor: NKLayoutYAxisAnchor { get }
        var lastBaselineAnchor: NKLayoutYAxisAnchor { get }
    }
#endif

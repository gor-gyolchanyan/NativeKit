//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    // Exposed

    ///
    open class NKShapedView: NKSimpleView {

        // Exposed

        // Class: NKShapedView
        // Topic: Main

        ///
        open func shape(in rectangle: NKRect) -> NKBezierPath {
            .init(rect: rectangle)
        }

        ///
        open func setNeedsUpdateShape() {
            _needsUpdateShape = true
        }

        // Class: NKSimpleView
        // Topic: Main

        ///
        public override init() {
            _maskingLayer = .init()
            _needsUpdateShape = true
            super.init()
            layer.mask = _maskingLayer
        }

        // Class: NKView
        // Topic: Laying Out Subviews

        open override func layoutSubviews() {
            super.layoutSubviews()
            setNeedsUpdateShape()
            _updateShape()
        }

        // Concealed

        // Class: NKShapedView
        // Topic: Main

        private let _maskingLayer: NKShapeLayer
        private var _needsUpdateShape: Bool
    }

    extension NKShapedView {

        // Concealed

        // Class: NKShapedView
        // Topic: Main

        private func _updateShape() {
            guard _needsUpdateShape else {
                return
            }
            _needsUpdateShape = false
            _maskingLayer.path = shape(in: frame).cgPath
        }
    }
#endif

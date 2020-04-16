//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
    import AppKit
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    import UIKit
#endif

#if os(macOS) || os(iOS) || os(tvOS)
    // Exposed

    ///
    open class NKGradientView: NKSimpleView {

        // Exposed

        // Type: NKGradientView
        // Topic: Main

        ///
        public init(
            firstColor: NKColor = .clear,
            lastColor: NKColor = .clear
        ) {
            self.firstColor = firstColor
            self.lastColor = lastColor
            super.init()
            _gradientLayer.startPoint = .init(x: 0.2, y: 0.8)
            _gradientLayer.endPoint = .init(x: 0.8, y: 0.2)
            _updateGradientLayer()
        }

        ///
        open var firstColor: NKColor {
            didSet {
                _updateGradientLayer()
            }
        }

        ///
        open var lastColor: NKColor {
            didSet {
                _updateGradientLayer()
            }
        }

        // Class: NKView
        // Topic: Configuring a View’s Visual Appearance

        #if os(macOS) && !targetEnvironment(macCatalyst)
        
        #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            open override class var layerClass: AnyClass {
                NKGradientLayer.self
            }
        #endif

        #if os(macOS) && !targetEnvironment(macCatalyst)
            open override func viewDidChangeEffectiveAppearance() {
                super.viewDidChangeEffectiveAppearance()
                _updateGradientLayer()
            }
        #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
            open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
                super.traitCollectionDidChange(previousTraitCollection)
                _updateGradientLayer()
            }
        #endif

        // Concealed

        // Class: NKGradientView
        // Topic: Main

        private var _gradientLayer: NKGradientLayer {
            layer as! NKGradientLayer
        }

        private func _updateGradientLayer() {
            _gradientLayer.colors = [
                firstColor.cgColor,
                lastColor.cgColor,
            ]
        }
    }
#endif

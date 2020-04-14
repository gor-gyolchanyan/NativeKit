//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS)
    import CoreGraphics

    extension NKLayoutGuide: NKLayoutRegion {

        // Exposed

        // Type: NKLayoutRegion
        // Topic: NKView

        public var translatesAutoresizingMaskIntoConstraints: Bool {
            get {
                false
            }

            set(translatesAutoresizingMaskIntoConstraints) {
                #if DEBUG
                    if translatesAutoresizingMaskIntoConstraints {
                        print("Warning: \(String(reflecting: Self.self)) does not support autoresizing behavior")
                    }
                #endif
            }
        }

        public var regionIdentifier: String? {
            #if os(macOS) && !targetEnvironment(macCatalyst)
                return identifier.rawValue
            #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
                return identifier
            #endif
        }

        public var regionFrame: CGRect {
            #if os(macOS) && !targetEnvironment(macCatalyst)
                return frame
            #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
                return layoutFrame
            #endif
        }

        public var regionView: NKView? { owningView }

        // Type: NKLayoutRegion
        // Topic: Vertical

        public var firstBaselineAnchor: NKLayoutYAxisAnchor {
            topAnchor
        }

        public var lastBaselineAnchor: NKLayoutYAxisAnchor {
            bottomAnchor
        }
    }
#endif

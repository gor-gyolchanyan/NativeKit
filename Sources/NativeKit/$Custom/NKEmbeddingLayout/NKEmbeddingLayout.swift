//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Exposed

#if os(macOS) || os(iOS) || os(tvOS)
    import Foundation

    // Exposed

    ///
    public final class NKEmbeddingLayout {

        // Exposed

        // Type: NKEmbeddingLayout
        // Topic: Main

        ///
        public init() {
            _innerRegion = nil
            _outerRegion = nil
            _constraints = nil
        }

        // Concealed

        // Type: NKEmbeddingLayout
        // Topic: Main

        deinit {
            uninstall()
        }

        private weak var _innerRegion: NKLayoutRegion?
        private weak var _outerRegion: NKLayoutRegion?
        private var _constraints: _Constraints?
    }

    extension NKEmbeddingLayout {

        // Exposed

        // Type: NKEmbeddingLayout
        // Topic: Main

        ///
        public convenience init(_ innerRegion: NKLayoutRegion, in outerRegion: NKLayoutRegion, edgeInsets: NKDirectionalEdgeInsets = .init(), affectedEdges: NKDirectionalRectEdge = .all) {
            self.init()
            install(innerRegion, in: outerRegion, edgeInsets: edgeInsets, affectedEdges: affectedEdges
            )
        }

        ///
        public var edgeInsets: NKDirectionalEdgeInsets {
            get {
                var result: NKDirectionalEdgeInsets
                result = .init()
                guard !_isExpired, let constraints = _constraints else { return result }
                result.leading = constraints.leading.constant
                result.trailing = constraints.trailing.constant
                result.top = constraints.top.constant
                result.bottom = constraints.bottom.constant
                return result
            }

            set(edgeInsets) {
                guard !_isExpired, let constraints = _constraints else { return }
                constraints.leading.constant = edgeInsets.leading
                constraints.trailing.constant = edgeInsets.trailing
                constraints.top.constant = edgeInsets.top
                constraints.bottom.constant = edgeInsets.bottom
            }
        }

        ///
        public var affectedEdges: NKDirectionalRectEdge {
            get {
                var result: NKDirectionalRectEdge
                result = .init()
                guard !_isExpired, let constraints = _constraints else { return result }
                if constraints.leading.isActive { result.insert(.leading) }
                if constraints.trailing.isActive { result.insert(.trailing) }
                if constraints.top.isActive { result.insert(.top) }
                if constraints.bottom.isActive { result.insert(.bottom) }
                return result
            }

            set(affectedEdges) {
                guard !_isExpired, let constraints = _constraints else { return }
                constraints.leading.isActive = affectedEdges.contains(.leading)
                constraints.trailing.isActive = affectedEdges.contains(.trailing)
                constraints.top.isActive = affectedEdges.contains(.top)
                constraints.bottom.isActive = affectedEdges.contains(.bottom)
            }
        }

        // Type: NKEmbeddingLayout
        // Topic: Installing

        ///
        public var isInstalled: Bool {
            !_isExpired && _constraints != nil
        }

        ///
        public func install(_ innerRegion: NKLayoutRegion, in outerRegion: NKLayoutRegion, edgeInsets: NKDirectionalEdgeInsets = .init(), affectedEdges: NKDirectionalRectEdge = .all) {
            uninstall()
            _innerRegion = innerRegion
            _outerRegion = outerRegion
            innerRegion.translatesAutoresizingMaskIntoConstraints = false
            _constraints = Self._makeConstraints(innerRegion, in: outerRegion)
            self.edgeInsets = edgeInsets
            self.affectedEdges = affectedEdges
        }

        ///
        public func uninstall() {
            if let constraints = _constraints {
                NKLayoutConstraint.deactivate([
                    constraints.leading,
                    constraints.trailing,
                    constraints.top,
                    constraints.bottom
                ])
            }
            _outerRegion = nil
            _innerRegion = nil
            _constraints = nil
        }

        // Concealed

        // Type: NKEmbeddingLayout
        // Topic: Main

        private typealias _Constraints = (leading: NKLayoutConstraint, trailing: NKLayoutConstraint, top: NKLayoutConstraint, bottom: NKLayoutConstraint)

        private static func _makeConstraints(_ innerRegion: NKLayoutRegion, in outerRegion: NKLayoutRegion) -> _Constraints {
            autoreleasepool {
                (
                    leading: innerRegion.leadingAnchor.constraint(equalTo: outerRegion.leadingAnchor),
                    trailing: outerRegion.trailingAnchor.constraint(equalTo: innerRegion.trailingAnchor),
                    top: innerRegion.topAnchor.constraint(equalTo: outerRegion.topAnchor),
                    bottom: outerRegion.bottomAnchor.constraint(equalTo: innerRegion.bottomAnchor)
                )
            }
        }

        private var _isExpired: Bool {
            _innerRegion == nil || _outerRegion == nil
        }
    }
#endif

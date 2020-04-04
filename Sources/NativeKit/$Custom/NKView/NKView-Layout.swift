//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) ||  os(iOS) || os(tvOS)
    import Combine
    import CoreGraphics

    extension NKView {

        // Exposed

        // Class: NKView
        // Topic: Layout

        public var frameChangePublisher: AnyPublisher<CGRect, Never> {
            Publishers.Merge6(
                layer.publisher(for: \.bounds).map { _ in },
                layer.publisher(for: \.position).map { _ in },
                layer.publisher(for: \.zPosition).map { _ in },
                layer.publisher(for: \.anchorPointZ).map { _ in },
                layer.publisher(for: \.anchorPoint).map { _ in },
                layer.publisher(for: \.transform).map { _ in }
            )
            .compactMap { [weak self] in
                guard let self = self else { return nil }
                return self.frame as CGRect?
            }
            .eraseToAnyPublisher()
        }
    }
#endif

//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
    import Combine
    import UIKit

    extension NKView {

        // Exposed

        // Type: NKView
        // Topic: NKKeyboard

        public var keyboardLayoutGuide: NKLayoutGuide {
            _KeyboardManager.for(self).keyboardLayoutGuide
        }

        public var withoutKeyboardLayoutGuide: NKLayoutGuide {
            _KeyboardManager.for(self).withoutKeyboardLayoutGuide
        }

        public var safeAreaWithoutKeyboardLayoutGuide: NKLayoutGuide {
            _KeyboardManager.for(self).safeAreaWithoutKeyboardLayoutGuide
        }

        // Concealed

        // Type: NKView
        // Topic: NKKeyboard

        fileprivate final class _KeyboardManager {

            // Exposed

            // Type: NKView._KeyboardManager
            // Topic: Main

            fileprivate static func `for`(_ view: NKView) -> Self {
                if let result =
                    objc_getAssociatedObject(
                        view,
                        Self._associatedObjectKey
                    ).map({
                        $0 as! Self
                    })
                {
                    return result
                }
                let result = Self(_view: view)
                objc_setAssociatedObject(
                    view,
                    Self._associatedObjectKey,
                    result,
                    .OBJC_ASSOCIATION_RETAIN
                )
                return result
            }

            fileprivate let keyboardLayoutGuide: NKLayoutGuide
            fileprivate let withoutKeyboardLayoutGuide: NKLayoutGuide
            fileprivate let safeAreaWithoutKeyboardLayoutGuide: NKLayoutGuide

            // Concealed

            // Type: UIView._KeyboardManager
            // Topic: Main

            private class var _associatedObjectKey: UnsafeRawPointer {
                unsafeBitCast(ObjectIdentifier(self), to: UnsafeRawPointer.self)
            }

            private init(_view view: NKView) {
                _view = view
                keyboardLayoutGuide = .init()
                withoutKeyboardLayoutGuide = .init()
                safeAreaWithoutKeyboardLayoutGuide = .init()
                _view.addLayoutGuide(keyboardLayoutGuide)
                _view.addLayoutGuide(withoutKeyboardLayoutGuide)
                _view.addLayoutGuide(safeAreaWithoutKeyboardLayoutGuide)
                _leftConstraint = keyboardLayoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor)
                _topConstraint = keyboardLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor)
                _widthConstraint = keyboardLayoutGuide.widthAnchor.constraint(equalToConstant: 0)
                _heightConstraint = keyboardLayoutGuide.heightAnchor.constraint(equalToConstant: 0)
                _configure()
            }

            private unowned let _view: NKView
            private let _leftConstraint: NSLayoutConstraint
            private let _topConstraint: NSLayoutConstraint
            private let _widthConstraint: NSLayoutConstraint
            private let _heightConstraint: NSLayoutConstraint
            private var _animator: UIViewPropertyAnimator?
            private var _frame: CGRect?
        }
    }

    extension NKView._KeyboardManager {

        // Concealed

        // Type: NKView._KeyboardManager
        // Topic: Main

        private class var _screen: UIScreen {
            .main
        }

        private func _configure() {
            do {
                let viewBottomConstraint = _view.bottomAnchor.constraint(equalTo: withoutKeyboardLayoutGuide.bottomAnchor)
                viewBottomConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
                NSLayoutConstraint.activate([
                    withoutKeyboardLayoutGuide.leadingAnchor.constraint(equalTo: _view.leadingAnchor),
                    _view.trailingAnchor.constraint(equalTo: withoutKeyboardLayoutGuide.trailingAnchor),
                    withoutKeyboardLayoutGuide.topAnchor.constraint(equalTo: _view.topAnchor),
                    viewBottomConstraint,
                    keyboardLayoutGuide.topAnchor.constraint(greaterThanOrEqualTo: withoutKeyboardLayoutGuide.bottomAnchor)
                ])
            }

            do {
                let viewBottomConstraint = _view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaWithoutKeyboardLayoutGuide.bottomAnchor)
                viewBottomConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.required.rawValue - 1)
                NSLayoutConstraint.activate([
                    safeAreaWithoutKeyboardLayoutGuide.leadingAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.leadingAnchor),
                    _view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: safeAreaWithoutKeyboardLayoutGuide.trailingAnchor),
                    safeAreaWithoutKeyboardLayoutGuide.topAnchor.constraint(equalTo: _view.safeAreaLayoutGuide.topAnchor),
                    viewBottomConstraint,
                    keyboardLayoutGuide.topAnchor.constraint(greaterThanOrEqualTo: safeAreaWithoutKeyboardLayoutGuide.bottomAnchor)
                ])
            }

            _updateConstraints()

            _view.frameChangePublisher.sink { [weak self] _ in
                guard let self = self else { return }
                self._updateConstraints()

            }.store(in: _view)

            NSLayoutConstraint.activate([
                _leftConstraint,
                _topConstraint,
                _widthConstraint,
                _heightConstraint,
            ])

            NKKeyboard.default.eventPublisher
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event.kind {
                    case .willChangeFrame:
                        if event.animationDuration == 0 {
                            self._frame = event.frameEnd
                            self._updateConstraints()
                            self._view.setNeedsLayout()
                            self._view.layoutIfNeeded()
                        } else {
                            if let animator = self._animator, animator.isRunning {
                                animator.stopAnimation(false)
                            }
                            self._frame = event.frameBegin
                            self._updateConstraints()
                            self._view.setNeedsLayout()
                            self._view.layoutIfNeeded()
                            let animator = UIViewPropertyAnimator(
                                duration: event.animationDuration,
                                curve: event.animationCurve
                            ) { [weak self] in
                                guard let self = self else { return }
                                self._frame = event.frameEnd
                                self._updateConstraints()
                                self._view.setNeedsLayout()
                                self._view.layoutIfNeeded()
                            }
                            animator.addCompletion { [weak self] _ in
                                guard let self = self else { return }
                                self._animator = nil
                            }
                            animator.startAnimation()
                            self._animator = animator
                        }
                    case .didChangeFrame:
                        break
                        // self._animator = nil
                }
            }
            .store(in: _view)
        }

        private func _updateConstraints() {
            let coordinateSpace = Self._screen.coordinateSpace
            let originalFrame: CGRect
            if let frame = _frame {
                originalFrame = frame
            } else {
                originalFrame = .init(
                    x: Self._screen.bounds.origin.x,
                    y: Self._screen.bounds.origin.y + Self._screen.bounds.size.height,
                    width: Self._screen.bounds.size.width,
                    height: Self._screen.bounds.size.height
                )
            }
            let convertedFrame = _view.convert(originalFrame, from: coordinateSpace).integral
            _leftConstraint.constant = convertedFrame.minX
            _topConstraint.constant = convertedFrame.minY
            _widthConstraint.constant = convertedFrame.width
            _heightConstraint.constant = convertedFrame.height
        }
    }
#endif

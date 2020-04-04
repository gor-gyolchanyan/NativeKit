//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

import NativeKit

#if os(iOS)
    import UIKit

    // Exposed

    public final class NKContainerView: NKSimpleView {

        // Exposed

        // Class: NKContainerView
        // Topic: Main

        public var doesDismissViewControllerWhenTappingOutsideContentView: Bool
        public var doesDismissKeyboardWhenTappingInsideContentView: Bool

        // Class: NKSimpleView
        // Topic: Main

        public override init() {
            doesDismissViewControllerWhenTappingOutsideContentView = true
            doesDismissKeyboardWhenTappingInsideContentView = true
            _contentViewOutsideTapGestureRecognizer = .init()
            _scrollView = .init()
            _paddingView = .init()
            _contentViewInsideTapGestureRecognizer = .init()
            _contentView = .init()
            _visibleAreaLayoutGuide = .init()
            _statusBarOverlayView = .init()
            _visibleAreaLayoutGuideConstraintArray = .init()
            _paddingViewSizeConstraintArray = .init()
            super.init()
            _contentViewOutsideTapGestureRecognizer.addTarget(self, action: #selector(_didTapOutsideContentView))
            addSubview(_scrollView)
            NSLayoutConstraint.activate([
                _scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
                trailingAnchor.constraint(equalTo: _scrollView.frameLayoutGuide.trailingAnchor),
                _scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
                bottomAnchor.constraint(equalTo: _scrollView.frameLayoutGuide.bottomAnchor),
            ])
            _scrollView.contentInsetAdjustmentBehavior = .always
            _scrollView.translatesAutoresizingMaskIntoConstraints = false
            _scrollView.addGestureRecognizer(_contentViewOutsideTapGestureRecognizer)
            _scrollView.addSubview(_paddingView)
            NSLayoutConstraint.activate([
                _paddingView.leadingAnchor.constraint(equalTo: _scrollView.contentLayoutGuide.leadingAnchor),
                _scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: _paddingView.trailingAnchor),
                _paddingView.topAnchor.constraint(equalTo: _scrollView.contentLayoutGuide.topAnchor),
                _scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: _paddingView.bottomAnchor),
            ])
            _paddingView.translatesAutoresizingMaskIntoConstraints = false
            _paddingView.addSubview(_contentView)
            NSLayoutConstraint.activate([
                _contentView.centerXAnchor.constraint(equalTo: _paddingView.centerXAnchor),
                _contentView.centerYAnchor.constraint(equalTo: _paddingView.centerYAnchor),
                _contentView.leadingAnchor.constraint(greaterThanOrEqualTo: _paddingView.leadingAnchor),
                _paddingView.trailingAnchor.constraint(greaterThanOrEqualTo: _contentView.trailingAnchor),
                _contentView.topAnchor.constraint(greaterThanOrEqualTo: _paddingView.topAnchor),
                _paddingView.bottomAnchor.constraint(greaterThanOrEqualTo: _contentView.bottomAnchor),
            ])
            _contentViewInsideTapGestureRecognizer.addTarget(self, action: #selector(_didTapInsideContentView))
            _contentView.addGestureRecognizer(_contentViewInsideTapGestureRecognizer)
            _contentView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(_statusBarOverlayView)
            NSLayoutConstraint.activate([
                _statusBarOverlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
                trailingAnchor.constraint(equalTo: _statusBarOverlayView.trailingAnchor),
                _statusBarOverlayView.topAnchor.constraint(equalTo: topAnchor),
                safeAreaLayoutGuide.topAnchor.constraint(equalTo: _statusBarOverlayView.bottomAnchor),
            ])
            _statusBarOverlayView.isHidden = true
            _statusBarOverlayView.effect = UIBlurEffect(style: .systemUltraThinMaterial)
            _statusBarOverlayView.translatesAutoresizingMaskIntoConstraints = false
            addLayoutGuide(_visibleAreaLayoutGuide)
            _visibleAreaLayoutGuideConstraintArray = [
                _visibleAreaLayoutGuide.leftAnchor.constraint(equalTo: safeAreaWithoutKeyboardLayoutGuide.leftAnchor),
                safeAreaWithoutKeyboardLayoutGuide.rightAnchor.constraint(equalTo: _visibleAreaLayoutGuide.rightAnchor),
                _visibleAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaWithoutKeyboardLayoutGuide.topAnchor),
                safeAreaWithoutKeyboardLayoutGuide.bottomAnchor.constraint(equalTo: _visibleAreaLayoutGuide.bottomAnchor),
            ]
            NSLayoutConstraint.activate(_visibleAreaLayoutGuideConstraintArray)
            _paddingViewSizeConstraintArray = [
                safeAreaWithoutKeyboardLayoutGuide.widthAnchor.constraint(lessThanOrEqualTo: _paddingView.widthAnchor),
                safeAreaWithoutKeyboardLayoutGuide.heightAnchor.constraint(lessThanOrEqualTo: _paddingView.heightAnchor),
            ]
            NSLayoutConstraint.activate(_paddingViewSizeConstraintArray)

            visibleAreaInsets = .init(
                top: 8,
                left: 8,
                bottom: 8,
                right: 8
            )
        }

        // Class: NKView
        // Topic: Laying Out Subviews

        public override func layoutSubviews() {
            super.layoutSubviews()
            let keyboardFrameHeight = frame.height - withoutKeyboardLayoutGuide.layoutFrame.height
            let topInset = _contentView.frame.height < _visibleAreaLayoutGuide.layoutFrame.height ? 0 : visibleAreaInsets.top
            let bottomInset = keyboardFrameHeight == .zero ? 0 : keyboardFrameHeight - safeAreaInsets.bottom
            _scrollView.contentInset = NKEdgeInsets(
                top: topInset,
                left: visibleAreaInsets.left,
                bottom: visibleAreaInsets.bottom + bottomInset,
                right: visibleAreaInsets.right
            )
            _scrollView.scrollIndicatorInsets = NKEdgeInsets(
                top: -topInset,
                left: 0,
                bottom: bottomInset,
                right: 0
            )
        }

        // Concealed

        // Class: NKContainerView
        // Topic: Main

        private let _contentViewOutsideTapGestureRecognizer: UITapGestureRecognizer
        private let _scrollView: NKScrollView
        private let _paddingView: NKView
        private let _contentViewInsideTapGestureRecognizer: UITapGestureRecognizer
        private let _contentView: NKView
        private let _visibleAreaLayoutGuide: NKLayoutGuide
        private let _statusBarOverlayView: NKVisualEffectView
        private var _visibleAreaLayoutGuideConstraintArray: [NSLayoutConstraint]
        private var _paddingViewSizeConstraintArray: [NSLayoutConstraint]
    }

    extension NKContainerView {

        // Exposed

        // Class: NKContainerView
        // Topic: Main

        public var contentView: NKView {
            _contentView
        }

        public var visibleAreaLayoutGuide: NKLayoutGuide {
            _visibleAreaLayoutGuide
        }

        public var doesDisplayStatusBarOverlay: Bool {
            get {
                !_statusBarOverlayView.isHidden
            }

            set(doesDisplayStatusBarOverlay) {
                _statusBarOverlayView.isHidden = !doesDisplayStatusBarOverlay
            }
        }

        public var visibleAreaInsets: NKEdgeInsets {
            get {
                .init(
                    top: _visibleAreaLayoutGuideConstraintArray[2].constant,
                    left: _visibleAreaLayoutGuideConstraintArray[0].constant,
                    bottom: _visibleAreaLayoutGuideConstraintArray[3].constant,
                    right: _visibleAreaLayoutGuideConstraintArray[1].constant
                )
            }

            set(visibleAreaInsets) {
                _visibleAreaLayoutGuideConstraintArray[0].constant = visibleAreaInsets.left
                _visibleAreaLayoutGuideConstraintArray[1].constant = visibleAreaInsets.right
                _visibleAreaLayoutGuideConstraintArray[2].constant = visibleAreaInsets.top
                _visibleAreaLayoutGuideConstraintArray[3].constant = visibleAreaInsets.bottom
                _paddingViewSizeConstraintArray[0].constant = visibleAreaInsets.left + visibleAreaInsets.right
                _paddingViewSizeConstraintArray[1].constant = visibleAreaInsets.top + visibleAreaInsets.bottom
            }
        }

        // Concealed

        // Class: NKContainerView
        // Topic: Main

        @objc
        private func _didTapOutsideContentView() {
            if doesDismissViewControllerWhenTappingOutsideContentView {
                var currentResponder: NKResponder = self
                while let nextResponder = currentResponder.next {
                    currentResponder = nextResponder
                    if
                        let viewController = currentResponder as? NKViewController,
                        viewController.presentingViewController != nil
                    {
                        viewController.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                _didTapInsideContentView()
            }
        }

        @objc
        private func _didTapInsideContentView() {
            if doesDismissKeyboardWhenTappingInsideContentView {
                _contentView.endEditing(false)
            }
        }
    }
#endif

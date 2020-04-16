//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)

    // Exposed

    ///
    open class NKControllerView<OuterViewController, InnerViewController>: NKSimpleView
    where OuterViewController: NKViewController, InnerViewController: NKViewController {

        // Exposed

        // Class: NKControllerView
        // Topic: Main

        ///
        open var isOuterViewControllerDetectionEnabled: Bool {
            didSet {
                _updateOuterViewController()
            }
        }

        ///
        open weak var outerViewController: OuterViewController? {
            get {
                _outerViewController
            }

            set(outerViewController) {
                isOuterViewControllerDetectionEnabled = false
                _changeOuterViewController(outerViewController)
            }
        }

        ///
        open var innerViewController: InnerViewController? {
            get {
                _innerViewController
            }

            set(innerViewController) {
                _changeInnerViewController(innerViewController)
            }
        }

        // Class: NKSimpleView
        // Topic: Main

        public override init() {
            isOuterViewControllerDetectionEnabled = false
            _innerViewLayout = .init()
            _outerViewController = nil
            _innerViewController = nil
            super.init()
        }

        // Class: NKView
        // Topic: Observing View-Related Changes

        public override func didMoveToSuperview() {
            super.didMoveToSuperview()
            #warning("BUG: Apparently, didMoveToSuperview() isn't enough to detect view controller change.")
            _updateOuterViewController()
        }

        // Concealed

        // Class: NKControllerView
        // Topic: Main

        let _innerViewLayout: NKEmbeddingLayout

        var _outerViewController: OuterViewController?

        var _innerViewController: InnerViewController?
    }

    extension NKControllerView {

        // Concealed

        // Class: NKControllerView
        // Topic: Main

        func _updateOuterViewController() {
            if isOuterViewControllerDetectionEnabled {
                _changeOuterViewController(nearestAncestorViewController())
            }
        }

        func _changeOuterViewController(_ newOuterViewController: OuterViewController?) {
            let oldOuterViewController = _outerViewController
            _outerViewController = newOuterViewController
            guard let innerViewController = _innerViewController else {
                return
            }
            switch (oldOuterViewController, newOuterViewController) {
                case (nil, nil):
                    return
                case (nil, let newOuterViewController?):
                    _validateOuterViewController(newOuterViewController)
                    return _attachInnerViewController(
                        innerViewController,
                        to: newOuterViewController
                    )
                case (let oldOuterViewController?, nil):
                    return _detachInnerViewController(
                        innerViewController,
                        from: oldOuterViewController
                    )
                case (let oldOuterViewController?, let newOuterViewController?):
                    guard oldOuterViewController != newOuterViewController else {
                        return
                    }
                    _validateOuterViewController(newOuterViewController)
                    return _reattachInnerViewController(
                        innerViewController,
                        from: oldOuterViewController,
                        to: newOuterViewController
                    )
            }
        }

        func _changeInnerViewController(_ newInnerViewController: InnerViewController?) {
            let oldInnerViewController = _innerViewController
            _innerViewController = newInnerViewController
            guard let outerViewController = _outerViewController else {
                return
            }
            switch (oldInnerViewController, newInnerViewController) {
                case (nil, nil):
                    return
                case (nil, let newInnerViewController?):
                    return _attachInnerViewController(
                        newInnerViewController,
                        to: outerViewController
                    )
                case (let oldInnerViewController?, nil):
                    return _detachInnerViewController(
                        oldInnerViewController,
                        from: outerViewController
                    )
                case (let oldInnerViewController?, let newInnerViewController?):
                    guard oldInnerViewController != newInnerViewController else {
                        return
                    }
                    return _reattachOuterViewController(
                        outerViewController,
                        from: oldInnerViewController,
                        to: newInnerViewController
                    )
            }
        }

        func _attachInnerViewController(
            _ innerViewController: InnerViewController,
            to newOuterViewController: OuterViewController
        ) {
            newOuterViewController.addChild(innerViewController)
            let innerView = innerViewController.nkView
            addSubview(innerView)
            _innerViewLayout.install(innerView, in: self)
            innerViewController.didMove(toParent: newOuterViewController)
        }

        func _detachInnerViewController(
            _ innerViewController: InnerViewController,
            from oldOuterViewController: OuterViewController
        ) {
            innerViewController.willMove(toParent: nil)
            if let innerView = innerViewController.viewIfLoaded {
                _innerViewLayout.uninstall()
                innerView.removeFromSuperview()
            }
            innerViewController.removeFromParent()
        }

        func _reattachInnerViewController(
            _ innerViewController: InnerViewController,
            from oldOuterViewController: OuterViewController,
            to newOuterViewController: OuterViewController
        ) {
            newOuterViewController.addChild(innerViewController)
            innerViewController.didMove(toParent: newOuterViewController)
        }

        func _reattachOuterViewController(
            _ outerViewController: OuterViewController,
            from oldInnerViewController: InnerViewController,
            to newInnerViewController: InnerViewController
        ) {
            _detachInnerViewController(
                oldInnerViewController,
                from: outerViewController
            )
            _attachInnerViewController(
                newInnerViewController,
                to: outerViewController
            )
        }

        func _validateOuterViewController(_ outerViewController: OuterViewController) {
            let outerView = outerViewController.nkView
            guard isDescendant(of: outerView) else {
                preconditionFailure("Invalid outer view controller: A valid outer view controller is one whose view is a direct or indirect supeview of this view.")
            }
        }
    }
#endif

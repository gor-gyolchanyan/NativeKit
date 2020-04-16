//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

extension NKView {

    // Exposed

    // Type: NKView
    // Topic: NKViewController

    ///
    public func nearestAncestorViewController<ViewController>(_ viewControllerType: ViewController.Type = ViewController.self) -> ViewController?
    where ViewController: NKViewController {
        assert(viewControllerType == ViewController.self)
        var currentResponder: NKResponder = self
        while let nextResponder = currentResponder.nkNextResponder {
            currentResponder = nextResponder
            if
                let viewController = currentResponder as? ViewController,
                let view = viewController.viewIfLoaded,
                isDescendant(of: view)
            {
                return viewController
            }
        }
        return nil
    }

}

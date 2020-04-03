//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
    import AppKit
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    import UIKit
#endif

// Exposed

#if os(macOS) && !targetEnvironment(macCatalyst)
    ///
    @available(macOS 10.11, *)
    public typealias NKLayoutGuide = AppKit.NSLayoutGuide
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    ///
    @available(macCatalyst 13.0, iOS 9.0, tvOS 9.0, *)
    public typealias NKLayoutGuide = UIKit.UILayoutGuide
#endif

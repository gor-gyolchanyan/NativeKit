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
    public typealias NKTextView = AppKit.NSTextView
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    ///
    public typealias NKTextView = UIKit.UITextView
#endif

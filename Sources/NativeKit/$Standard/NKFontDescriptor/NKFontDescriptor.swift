//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
    import AppKit
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#endif

// Exposed

#if os(macOS) && !targetEnvironment(macCatalyst)
    ///
    public typealias NKFontDescriptor = AppKit.NSFontDescriptor
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    ///
    public typealias NKFontDescriptor = UIKit.UIFontDescriptor
#endif

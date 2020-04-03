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
    @available(macOS 10.3, *)
    public typealias NKFontDescriptor = AppKit.NSFontDescriptor
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    ///
    @available(macCatalyst 13.0, iOS 7.0, tvOS 9.0, watchOS 2.0, *)
    public typealias NKFontDescriptor = UIKit.UIFontDescriptor
#endif

//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
    import AppKit
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
    import UIKit
#endif

// Exposed

#if os(macOS) && !targetEnvironment(macCatalyst)
    ///
    @available(macOS 10.15, *)
    public typealias NKSwitch = AppKit.NSSwitch
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
    ///
    @available(macCatalyst 13.0, iOS 2.0, *)
    public typealias NKSwitch = UIKit.UISwitch
#endif

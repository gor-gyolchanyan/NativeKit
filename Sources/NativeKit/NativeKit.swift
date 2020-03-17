//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    @_exported import UIKit
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    @_exported import AppKit
#endif

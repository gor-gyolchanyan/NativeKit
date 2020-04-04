//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && !targetEnvironment(macCatalyst)
    import AppKit
#elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
    import UIKit
#endif

#if os(macOS) || os(iOS) || os(tvOS)
    extension NKApplication {

        // Exposed

        // Type: NKApplication
        // Topic: Launch

        ///
        public static func launch(_ delegateType: (NKResponder & NKApplicationDelegate).Type) -> Never {
            #if os(macOS) && !targetEnvironment(macCatalyst)
                let delegate = delegateType.init()
                NKApplication.shared.delegate = delegate
                _ = AppKit.NSApplicationMain(
                    CommandLine.argc,
                    CommandLine.unsafeArgv
                )
                preconditionFailure("AppKit.NSApplicationMain is not expected to return.")
            #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
                _ = UIKit.UIApplicationMain(
                    CommandLine.argc,
                    CommandLine.unsafeArgv,
                    nil,
                    Foundation.NSStringFromClass(delegateType)
                )
                preconditionFailure("UIKit.UIApplicationMain is not expected to return.")
            #endif
        }
    }
#endif

//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeApplication
// Topic: Launch

extension NativeApplication {

    // Exposed

    public static func launch(_ delegateType: (NativeResponder & NativeApplicationDelegate).Type) -> Never {
        #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
        _ = UIApplicationMain(
            CommandLine.argc,
            CommandLine.unsafeArgv,
            nil,
            NSStringFromClass(delegateType)
        )
        preconditionFailure("UIApplicationMain is not expected to return.")
        #elseif os(macOS) && !targetEnvironment(macCatalyst)
        let delegate = delegateType.init()
        NativeApplication.shared.delegate = delegate
        _ = NSApplicationMain(
            CommandLine.argc,
            CommandLine.unsafeArgv
        )
        preconditionFailure("NSApplicationMain is not expected to return.")
        #endif
    }
}

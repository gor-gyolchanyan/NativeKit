//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeApplicationDelegate

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    public typealias NativeApplicationDelegate = UIApplicationDelegate
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    public typealias NativeApplicationDelegate = NSApplicationDelegate
#endif

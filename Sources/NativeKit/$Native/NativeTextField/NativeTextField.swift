//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeTextField

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    public typealias NativeTextField = UITextField
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    public typealias NativeTextField = NSTextField
#endif

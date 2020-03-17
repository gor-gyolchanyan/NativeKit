//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeStackView

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    @available(macCatalyst 13.0, iOS 9.0, tvOS 9.0, *)
    public typealias NativeStackView = UIStackView
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    public typealias NativeStackView = NSStackView
#endif

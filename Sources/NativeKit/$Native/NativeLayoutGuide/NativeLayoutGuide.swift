//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeLayoutGuide

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    @available(macCatalyst 13.0, iOS 9.0, tvOS 9.0, *)
    public typealias NativeLayoutGuide = UILayoutGuide
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    @available(macOS 10.11, *)
    public typealias NativeLayoutGuide = NSLayoutGuide
#endif

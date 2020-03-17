//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeCollectionViewLayout

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    public typealias NativeCollectionViewLayout = UICollectionViewLayout
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    @available(macOS 10.11, *)
    public typealias NativeCollectionViewLayout = NSCollectionViewLayout
#endif


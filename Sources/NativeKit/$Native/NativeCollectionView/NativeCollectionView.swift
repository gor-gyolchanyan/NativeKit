//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeCollectionView

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    public typealias NativeCollectionView = UICollectionView
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    public typealias NativeCollectionView = NSCollectionView
#endif

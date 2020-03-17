//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeCollectionViewCompositionalLayout

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
@available(macCatalyst 13.0, iOS 13.0, tvOS 13.0, *)
    public typealias NativeCollectionViewCompositionalLayout = UICollectionViewCompositionalLayout
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    @available(macOS 10.15, *)
    public typealias NativeCollectionViewCompositionalLayout = NSCollectionViewCompositionalLayout
#endif


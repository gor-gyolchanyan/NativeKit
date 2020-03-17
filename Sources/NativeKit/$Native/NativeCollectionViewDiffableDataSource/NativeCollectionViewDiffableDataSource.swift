//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeCollectionViewDiffableDataSource

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
@available(macCatalyst 13.0, iOS 13.0, tvOS 13.0, *)
    public typealias NativeCollectionViewDiffableDataSource = UICollectionViewDiffableDataSource
#elseif os(macOS) && !targetEnvironment(macCatalyst)
    @available(macOS 10.15.1, *)
    public typealias NativeCollectionViewDiffableDataSource = NSCollectionViewDiffableDataSource
#endif

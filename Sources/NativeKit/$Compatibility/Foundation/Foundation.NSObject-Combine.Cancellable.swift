//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    import Combine
    import Foundation

    extension Combine.Cancellable {

        // Exposed

        // Type: Combine.Cancellable
        // Topic: Foundation.NSObject

        public func store<Object>(in object: Object)
        where Object: Foundation.NSObject {
            object._combineCancellableSet.add(self)
        }
    }

    extension Foundation.NSObject {

        // Concealed

        // Class: Foundation.NSObject
        // Topic: Combine.Cancellable

        fileprivate typealias _CombineCancellableSet = Set<Combine.AnyCancellable>

        private static var _combineCancellableSetAssociatedObjectKeyStorage: Void = ()
        private static let _combineCancellableSetAssociatedObjectKey = UnsafeRawPointer(&_combineCancellableSetAssociatedObjectKeyStorage)

        fileprivate var _combineCancellableSet: NSMutableSet {
            get {
                if let combineCancellableSet =
                    ObjectiveC.objc_getAssociatedObject(
                        self,
                        Self._combineCancellableSetAssociatedObjectKey
                    ).map({
                        $0 as! NSMutableSet
                    })
                {
                    return combineCancellableSet
                }
                let combineCancellableSet = NSMutableSet()
                ObjectiveC.objc_setAssociatedObject(
                    self,
                    Self._combineCancellableSetAssociatedObjectKey,
                    combineCancellableSet,
                    .OBJC_ASSOCIATION_RETAIN
                )
                return combineCancellableSet
            }
        }
    }
#endif

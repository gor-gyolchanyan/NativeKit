//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
    import Combine
    import UIKit

    // Exposed

    public final class NKKeyboard {

        // Concealed

        // Class: NKKeyboard
        // Topic: Main

        private init() {
            Self._didChangeKeyboardViewFrame
                .removeDuplicates()
                .sink { _frame in
                    Self._currentKeyboardFrame.send(_frame)
                }
                .store(in: &_cancellables)
        }

        private var _cancellables: Set<AnyCancellable> = .init()
    }

    extension NKKeyboard {

        // Exposed

        // Class: NKKeyboard
        // Topic: Main

        public static let `default` = NKKeyboard()

        public var eventPublisher: AnyPublisher<NKKeyboard.Event, Never> {
            Self._patchedEventPublisher
            .eraseToAnyPublisher()
        }

        // Concealed

        // Class: NKKeyboard
        // Topic: Main

        private static func _isKeyboardWindow(_ window: NKWindow) -> Bool {
            NSStringFromClass(type(of: window)) == "UIRemoteKeyboardWindow"
        }

        private static func _isKeyboardViewController(_ viewController: NKViewController) -> Bool {
            NSStringFromClass(type(of: viewController)) == "UIInputWindowController"
        }

        private static func _isKeyboardViewControllerView(_ view: NKView) -> Bool {
            NSStringFromClass(type(of: view)) == "UIInputSetContainerView"
        }

        private static func _isKeyboardView(_ view: NKView) -> Bool {
            NSStringFromClass(type(of: view)) == "UIInputSetHostView"
        }

        private static let _didChangeKeyboardWindow =
            Publishers.Merge(
                NotificationCenter.default
                    .publisher(for: NKWindow.didBecomeHiddenNotification)
                    .compactMap { $0.object as? NKWindow }
                    .filter(_isKeyboardWindow)
                    .map { _ in nil }
                ,
                NotificationCenter.default
                    .publisher(for: NKWindow.didBecomeVisibleNotification)
                    .compactMap { $0.object as? NKWindow }
                    .filter(_isKeyboardWindow)
                    .map { $0 as NKWindow? }
            )

        private static let _didChangeKeyboardViewController =
            _didChangeKeyboardWindow
            .flatMap { window -> AnyPublisher<NKViewController?, Never> in
                guard let window = window else {
                    return
                        Just(nil)
                        .eraseToAnyPublisher()
                }
                return window
                    .publisher(for: \.rootViewController)
                    .map { viewController in
                        guard
                            let viewController = viewController,
                            _isKeyboardViewController(viewController)
                        else {
                            return nil
                        }
                        return viewController
                    }
                    .eraseToAnyPublisher()
            }

        private static let _didChangeKeyboardViewControllerView =
            _didChangeKeyboardViewController
            .flatMap { viewController -> AnyPublisher<NKView?, Never> in
                guard let viewController = viewController else {
                    return
                        Just(nil)
                        .eraseToAnyPublisher()
                }
                return viewController
                    .publisher(for: \.viewIfLoaded)
                    .map { view in
                        guard
                            let view = view,
                            _isKeyboardViewControllerView(view)
                        else {
                            return nil
                        }
                        return view
                    }
                    .eraseToAnyPublisher()
            }

        private static let _didChangeKeyboardView =
            _didChangeKeyboardViewControllerView
            .flatMap { view -> AnyPublisher<NKView?, Never> in
                guard let view = view else {
                    return
                        Just(nil)
                        .eraseToAnyPublisher()
                }
                return view
                    .subviews.publisher
                    .filter(_isKeyboardView)
                    .map { $0 as NKView? }
                    .eraseToAnyPublisher()
            }

        private static let _didChangeKeyboardViewFrame =
            _didChangeKeyboardView
            .flatMap { view -> AnyPublisher<CGRect?, Never> in
                guard let view = view else {
                    return
                        Just(nil)
                        .eraseToAnyPublisher()
                }
                return
                    view.frameChangePublisher
                    .map { $0 as CGRect? }
                    .eraseToAnyPublisher()
            }

        private static let _currentKeyboardFrame: CurrentValueSubject<CGRect?, Never> =
            .init(nil)

        private static let _eventPublisher =
            Publishers.Merge(
                NotificationCenter
                    .default
                    .publisher(for: NKResponder.keyboardWillChangeFrameNotification)
                ,
                NotificationCenter
                    .default
                    .publisher(for: NKResponder.keyboardDidChangeFrameNotification)
            )
            .compactMap { notification -> NKKeyboard.Event? in
                guard
                    let userInfo = notification.userInfo,

                    let animationDurationUserInfoValue = userInfo[NKResponder.keyboardAnimationDurationUserInfoKey],
                    let animationDurationObject = animationDurationUserInfoValue as? NSNumber,
                    let animationDuration = TimeInterval(exactly: animationDurationObject),

                    let animationCurveUserInfoValue = userInfo[NKResponder.keyboardAnimationCurveUserInfoKey],
                    let animationCurveObject = animationCurveUserInfoValue as? NSNumber,
                    let animationCurveRawValue = NKView.AnimationCurve.RawValue(exactly: animationCurveObject),
                    let animationCurve = NKView.AnimationCurve(rawValue: animationCurveRawValue),

                    let frameBeginUserInfoValue = userInfo[NKResponder.keyboardFrameBeginUserInfoKey],
                    let frameBeginObject = frameBeginUserInfoValue as? NSValue,

                    let frameEndUserInfoValue = userInfo[NKResponder.keyboardFrameEndUserInfoKey],
                    let frameEndObject = frameEndUserInfoValue as? NSValue,

                    let isLocalUserInfoValue = userInfo[NKResponder.keyboardIsLocalUserInfoKey],
                    let isLocalObject = isLocalUserInfoValue as? NSNumber,
                    let isLocal = Bool(exactly: isLocalObject)
                    else {
                        return nil
                }

                let frameBegin = frameBeginObject.cgRectValue
                let frameEnd = frameEndObject.cgRectValue
                let kind: NKKeyboard.Event.Kind
                switch notification.name {
                    case NKResponder.keyboardWillChangeFrameNotification:
                        kind = .willChangeFrame
                    case NKResponder.keyboardDidChangeFrameNotification:
                        kind = .didChangeFrame
                    default:
                        return nil
                }
                return
                    .init(
                        animationDuration: animationDuration,
                        animationCurve: animationCurve,
                        frameBegin: frameBegin,
                        frameEnd: frameEnd,
                        isLocal: isLocal,
                        kind: kind
                    )
            }


        private static let _patchedEventPublisher =
            _eventPublisher
            .flatMap { event -> AnyPublisher<NKKeyboard.Event, Never> in
                switch event.kind {
                    case .willChangeFrame:
                        if event.animationDuration == 0 {
                            let frameBegin = _currentKeyboardFrame.value ?? event.frameBegin
                            return _currentKeyboardFrame
                                .first()
                                .flatMap { frameEnd -> Publishers.Sequence<[NKKeyboard.Event], Never> in
                                    let frameEnd = frameEnd ?? event.frameEnd
                                    return
                                        [
                                            NKKeyboard.Event(
                                                animationDuration: 0,
                                                animationCurve: event.animationCurve,
                                                frameBegin: frameBegin,
                                                frameEnd: frameEnd,
                                                isLocal: event.isLocal,
                                                kind: .willChangeFrame
                                            ),
                                            NKKeyboard.Event(
                                                animationDuration: 0,
                                                animationCurve: event.animationCurve,
                                                frameBegin: frameBegin,
                                                frameEnd: frameEnd,
                                                isLocal: event.isLocal,
                                                kind: .didChangeFrame
                                            )
                                        ]
                                        .publisher
                                }
                                .eraseToAnyPublisher()
                        } else {
                            return
                                Just(event)
                                .eraseToAnyPublisher()
                        }
                    case .didChangeFrame:
                        if event.animationDuration == 0 {
                            return
                                Empty(completeImmediately: true)
                                .eraseToAnyPublisher()
                        } else {
                            return
                                Just(event)
                                .eraseToAnyPublisher()
                        }
                }
            }
    }

    extension NKKeyboard {

        // Exposed

        // Type: NKKeyboard
        // Topic: Main

        public struct Event: Equatable {

            // Exposed

            // Type: NKKeyboard.Event
            // Topic: Main

            public let animationDuration: TimeInterval

            public let animationCurve: NKView.AnimationCurve

            public let frameBegin: CGRect

            public let frameEnd: CGRect

            public let isLocal: Bool

            public let kind: Kind

            // Exposed

            // Type: NKKeyboard.Event
            // Topic: Main

            fileprivate init(
                animationDuration: TimeInterval,
                animationCurve: NKView.AnimationCurve,
                frameBegin: CGRect,
                frameEnd: CGRect,
                isLocal: Bool,
                kind: Kind
            ) {
                self.animationDuration = animationDuration
                self.animationCurve = animationCurve
                self.frameBegin = frameBegin
                self.frameEnd = frameEnd
                self.isLocal = isLocal
                self.kind = kind
            }
        }
    }

    extension NKKeyboard.Event {

        // Exposed

        // Type: NKKeyboard.Event
        // Topic: Main

        public enum Kind {

            // Exposed

            // Type: NKKeyboard.Event.Kind
            // Topic: Main

            case willChangeFrame

            case didChangeFrame
        }
    }
#endif

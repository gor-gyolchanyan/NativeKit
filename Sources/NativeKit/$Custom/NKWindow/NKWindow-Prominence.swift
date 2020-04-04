//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS) || os(tvOS)
    @available(macOS 10.0, macCatalyst 13.0, iOS 2.0, tvOS 9.0, *)
    extension NKWindow {

        // Exposed

        // Type: NKWindow
        // Topic: Prominence

        ///
        public enum Prominence {

            // Exposed

            // Type: NKWindow.Prominence
            // Topic: Main

            ///
            case absent
            ///
            case recessive
            ///
            case dominant
        }

        ///
        public var prominence: Prominence {
            get {
                #if os(macOS) && !targetEnvironment(macCatalyst)
                    switch (isKeyWindow, isVisible) {
                        case (false, false):
                            return .absent
                        case (false, true):
                            return .recessive
                        case (true, false):
                            preconditionFailure("AppKit.NSWindow is not expected to be the key window and hidden at the same time.")
                        case (true, true):
                            return .dominant
                    }
                #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
                    switch (isKeyWindow, isHidden) {
                        case (false, false):
                            return .recessive
                        case (false, true):
                            return .absent
                        case (true, false):
                            return .dominant
                        case (true, true):
                            preconditionFailure("UIKit.UIWindow is not expected to be the key window and hidden at the same time.")
                    }
                #endif
            }

            set(prominence) {
                #if os(macOS) && !targetEnvironment(macCatalyst)
                    switch prominence {
                        case .absent:
                            orderOut(nil)
                        case .recessive:
                            if isVisible {
                                let animationBehavior_ = animationBehavior
                                animationBehavior = .none
                                orderOut(nil)
                                orderFront(nil)
                                animationBehavior = animationBehavior_
                            } else {
                                orderFront(nil)
                            }
                        case .dominant:
                            makeKeyAndOrderFront(nil)
                    }
                #elseif os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS)
                    switch prominence {
                        case .absent:
                            isHidden = true
                        case .recessive:
                            if isHidden {
                                isHidden = false
                            } else {
                                let areAnimationsEnabled_ = NKView.areAnimationsEnabled
                                NKView.setAnimationsEnabled(false)
                                isHidden = true
                                isHidden = false
                                NKView.setAnimationsEnabled(areAnimationsEnabled_)
                        }
                        case .dominant:
                            makeKeyAndVisible()
                    }
                #endif
            }
       }
    }
#endif

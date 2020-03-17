//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

// Type: NativeWindow.Prominence

extension NativeWindow {
    public enum Prominence {

        // Topic: Main

        // Exposed

        case absent

        case recessive

        case dominant
    }
}

// Type: NativeWindow
// Topic: NativeWindow.Prominence

extension NativeWindow {

    // Exposed

    #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS) || os(tvOS) || os(watchOS)
    public var prominence: Prominence {
        get {
            switch (isKeyWindow, isHidden) {
                case (false, false):
                    return .recessive
                case (false, true):
                    return .absent
                case (true, false):
                    return .dominant
                case (true, true):
                    preconditionFailure("A UIWindow is not expected to be a key window and hidden at the same time.")
            }
        }

        set(prominence) {
            switch prominence {
                case .absent:
                    isHidden = true
                case .recessive:
                    if isHidden {
                        isHidden = false
                    } else {
                        isHidden = true
                        isHidden = false
                    }
                case .dominant:
                    isHidden = false
                    makeKey()
            }
        }
    }
    #endif
}

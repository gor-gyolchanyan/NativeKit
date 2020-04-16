//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS)
    import AVFoundation

    extension AVCaptureSession {

        // Exposed

        // Type: AVCaptureSession
        // Topic: NKMediaRecorder

        public internal(set) var mediaRecorder: NKMediaRecorder? {
            get {
                guard
                    let mediaRecorderAssociatedObject =
                        objc_getAssociatedObject(
                            self,
                            mediaRecorderAssociatedObjectKey
                        ),
                    let mediaRecorder = mediaRecorderAssociatedObject as? NKMediaRecorder
                else {
                    return nil
                }
                return mediaRecorder
            }

            set(mediaRecorder) {
                objc_setAssociatedObject(
                    self,
                    mediaRecorderAssociatedObjectKey,
                    mediaRecorder,
                    .OBJC_ASSOCIATION_ASSIGN
                )
            }
        }

        // Concealed

        var mediaRecorderAssociatedObjectKey: UnsafeRawPointer {
            unsafeBitCast(ObjectIdentifier(Self.self), to: UnsafeRawPointer.self)
        }
    }
#endif

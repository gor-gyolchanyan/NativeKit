//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS)
    // Exposed

    extension NKMediaRecorder {

        // Exposed

        // Type: NKMediaRecorder
        // Topic: CreationError

        /// An error thrown when creating a `NKMediaRecorder`.
        public enum CreationError {

            // Exposed

            // Type: NKMediaRecorder.CreationError
            // Topic: Main

            /// No audio input device could be acquired.
            case missingAudioInput

            /// There is an audio input device, but it isn't readable.
            case unreadableAudioInput(Error)

            /// There is an audio input device and it's readable, but it isn't usable.
            case unusableAudioInput

            /// No video input device could be acquired.
            case missingVideoInput

            /// There is a video input device, but it isn't readable.
            case unreadableVideoInput(Error)

            /// There is an audio input device and it's readable, but it isn't usable.
            case unusableVideoInput

            /// There is a media file output destination, but it isn't usable.
            case unusableMediaFileOutput
        }
    }

    extension NKMediaRecorder.CreationError: Error { }
#endif

//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS)
    // Exposed

    extension NKMediaRecorder {

        // Exposed

        // Type: NKMediaRecorder
        // Topic: OperationError

        /// An error thrown when operating a `NKMediaRecorder`.
        public enum OperationError {

            // Exposed

            // Type: NKMediaRecorder.OperationError
            // Topic: Main

            /// Failed to confiure the audio sessio.
            case failedToConfigureAudioSession(Error)

            /// Failed to activate the audio session.
            case failedToActivateAudioSession(Error)

            /// Failed to deactivate the audio session.
            case failedToDeactivateAudioSession(Error)

            /// Failed to write to the media file.
            case failedToWriteToMediaFile(Error)

            /// Failed to trigger a start-recording operation because it's already triggered.
            case startRecordingAlreadyTriggered

            /// Failed to trigger a stop-recording operation because it's already triggered.
            case stopRecordingAlreadyTriggered
        }
    }

    extension NKMediaRecorder.OperationError: Error { }
#endif

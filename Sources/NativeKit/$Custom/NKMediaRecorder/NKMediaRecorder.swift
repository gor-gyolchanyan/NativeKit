//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS)
    import Foundation

    // Exposed

    /// A type that is able to record audio from an audio device and video from a video device and write it all into a media file.
    public final class NKMediaRecorder {

        // Exposed

        // Type: NKMediaRecorder
        // Topic: Main

        public let mediaFile: URL

        // Concealed

        // Type: NKMediaRecorder
        // Topic: Main

        init(
            captureSession: CaptureSession,
            mediaFile: URL,
            mediaFileOutput: CaptureMediaFileOutput
        ) {
            self.captureSession = captureSession
            self.mediaFile = mediaFile
            self.mediaFileOutput = mediaFileOutput
            self.audioCaptureDeviceInput = nil
            self.videoCaptureDeviceInput = nil
            onStartRecording = nil
            onStopRecording = nil

            self.captureSession.mediaRecorder = self
        }

        deinit {
            self.captureSession.mediaRecorder = nil
        }

        lazy var agent = Agent(self)

        let captureSession: CaptureSession
        let mediaFileOutput: CaptureMediaFileOutput

        var videoCaptureDeviceInput: CaptureDeviceInput?
        var audioCaptureDeviceInput: CaptureDeviceInput?

        var onStartRecording: ((OperationError?) -> Void)?
        var onStopRecording: ((OperationError?) -> Void)?
    }
#endif

//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS)
    import AVFoundation

    extension NKMediaRecorder {

        // Concealed

        // Type: NKMediaRecorder
        // Topic: Agent

        final class Agent: NSObject {

            // Exposed

            // Type: NKMediaRecorder
            // Topic: Agent

            init(_ agency: Agency) {
                self.agency = agency
            }

            unowned let agency: Agency
        }
    }

    extension NKMediaRecorder.Agent {

        // Exposed

        // Type: NKMediaRecorder
        // Topic: Agent

        typealias Agency = NKMediaRecorder
    }

    extension NKMediaRecorder.Agent: AVCaptureFileOutputRecordingDelegate {

        // Exposed

        // Protocol: AVCaptureFileOutputRecordingDelegate
        // Topic: Delegate Methods

        func fileOutput(
            _ output: AVCaptureFileOutput,
            didStartRecordingTo fileURL: URL,
            from connections: [AVCaptureConnection]
        ) {
            guard let onStartRecording = agency.onStartRecording else {
                return
            }
            agency.onStartRecording = nil
            return onStartRecording(nil)
        }

        func fileOutput(
            _ output: AVCaptureFileOutput,
            didFinishRecordingTo outputFileURL: URL,
            from connections: [AVCaptureConnection],
            error: Error?
        ) {
            guard let onStopRecording = agency.onStopRecording else {
                return
            }
            agency.onStopRecording = nil
            if let error = error {
                return onStopRecording(.failedToWriteToMediaFile(error))
            }
            return onStopRecording(nil)
        }
    }
#endif

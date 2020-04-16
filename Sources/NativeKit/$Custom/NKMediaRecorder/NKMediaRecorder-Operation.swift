//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS)
    import AVFoundation

    extension NKMediaRecorder {

        // Exposed

        // Type: NKMediaRecorder
        // Topic: Operation

        ///
        public enum Content {

            // Exposed

            // Type: NKMediaRecorder.Content
            // Topic: Main

            ///
            case none

            ///
            case audioOnly

            ///
            case videoOnly

            ///
            case audioAndVideo
        }

        /// Determines whether or not capturing is in progress.
        public var isCapturing: Bool {
            captureSession.isRunning
        }

        /// Determines whether or not a recording session is in progress.
        public var isRecording: Bool {
            mediaFileOutput.isRecording
        }

        public var content: Content {
            get {
                switch (audioCaptureDeviceInput != nil, videoCaptureDeviceInput != nil) {
                    case (false, false):
                        return .none
                    case (false, true):
                        return .videoOnly
                    case (true, false):
                        return .audioOnly
                    case (true, true):
                        return .audioAndVideo
                }
            }
        }

        public func setContent(_ content: Content) throws {
            captureSession.beginConfiguration()
            switch content {
                case .none:
                    uninstallAudioCaptureDeviceInput()
                    uninstallVideoCaptureDeviceInput()
                case .audioOnly:
                    try installAudioCaptureDeviceInput()
                    uninstallVideoCaptureDeviceInput()
                case .videoOnly:
                    uninstallAudioCaptureDeviceInput()
                    try installVideoCaptureDeviceInput()
                case .audioAndVideo:
                    try installAudioCaptureDeviceInput()
                    try installVideoCaptureDeviceInput()
            }
            captureSession.commitConfiguration()
        }

        /// Start capturing content from the input devices.
        public func startCapturing() throws {
            guard !isCapturing else {
                return
            }
            if let error = Self.configureAudioSession() {
                throw OperationError.failedToConfigureAudioSession(error)
            }
            if let error = Self.activateAudioSession() {
                throw OperationError.failedToActivateAudioSession(error)
            }
            captureSession.startRunning()
        }

        /// Stop capturing content from the input devices.
        public func stopCapturing() throws {
            guard isCapturing else {
                return
            }
            captureSession.stopRunning()
            if let error = Self.deactivateAudioSession() {
                throw OperationError.failedToDeactivateAudioSession(error)
            }
        }

        /// Trigger a start-recording operation.
        ///
        /// - completion: The function that will be called when the operation is complete.
        public func startRecording(completion onStartRecording: @escaping (OperationError?) -> Void) {
            guard self.onStartRecording == nil else {
                return onStartRecording(.startRecordingAlreadyTriggered)
            }
            guard !isRecording else {
                return onStartRecording(nil)
            }
            self.onStartRecording = onStartRecording
            mediaFileOutput.startRecording(
                to: mediaFile,
                recordingDelegate: agent
            )
        }

        /// Trigger a stop-recording operation.
        ///
        /// - completion: The function that will be called when the operation is complete.
        public func stopRecording(completion onStopRecording: @escaping (OperationError?) -> Void) {
            guard self.onStopRecording == nil else {
                return onStopRecording(.stopRecordingAlreadyTriggered)
            }
            guard isRecording else {
                return onStopRecording(nil)
            }
            self.onStopRecording = onStopRecording
            mediaFileOutput.stopRecording()
        }
        // Concealed

        // Type: NKMediaRecorder
        // Topic: Operation

        func installAudioCaptureDeviceInput() throws {
            guard self.audioCaptureDeviceInput == nil else {
                return
            }

            guard let audioCaptureDevice = Self.makeAudioCaptureDevice() else {
                throw NKMediaRecorder.CreationError.missingAudioInput
            }

            let audioCaptureDeviceInput: AVCaptureDeviceInput
            do {
                try audioCaptureDeviceInput = Self.makeAudioCaptureDeviceInput(device: audioCaptureDevice)
            } catch {
                throw NKMediaRecorder.CreationError.unreadableAudioInput(error)
            }

            guard captureSession.canAddInput(audioCaptureDeviceInput) else {
                throw NKMediaRecorder.CreationError.unusableAudioInput
            }
            captureSession.addInput(audioCaptureDeviceInput)

            self.audioCaptureDeviceInput = audioCaptureDeviceInput
        }

        func installVideoCaptureDeviceInput() throws {
            guard self.videoCaptureDeviceInput == nil else {
                return
            }

            guard let videoCaptureDevice = Self.makeVideoCaptureDevice() else {
                throw NKMediaRecorder.CreationError.missingVideoInput
            }

            let videoCaptureDeviceInput: AVCaptureDeviceInput
            do {
                try videoCaptureDeviceInput = Self.makeVideoCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                throw NKMediaRecorder.CreationError.unreadableVideoInput(error)
            }

            guard captureSession.canAddInput(videoCaptureDeviceInput) else {
                throw NKMediaRecorder.CreationError.unusableVideoInput
            }
            captureSession.addInput(videoCaptureDeviceInput)

            self.videoCaptureDeviceInput = videoCaptureDeviceInput
        }

        func uninstallAudioCaptureDeviceInput() {
            guard let audioCaptureDeviceInput = self.audioCaptureDeviceInput else {
                return
            }
            captureSession.removeInput(audioCaptureDeviceInput)
            self.audioCaptureDeviceInput = nil
        }

        func uninstallVideoCaptureDeviceInput() {
            guard let videoCaptureDeviceInput = self.videoCaptureDeviceInput else {
                return
            }
            captureSession.removeInput(videoCaptureDeviceInput)
            self.videoCaptureDeviceInput = nil
        }

        class func configureAudioSession() -> OperationError? {
            #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
                do {
                    try Self.audioSession.setCategory(
                        .record,
                        mode: .spokenAudio,
                        policy: .default,
                        options: [ ]
                    )
                    return nil
                } catch {
                    return .failedToConfigureAudioSession(error)
                }
            #else
                return nil
            #endif
        }

        class func activateAudioSession() -> OperationError? {
            #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
                do {
                    try Self.audioSession.setActive(
                        true,
                        options: [.notifyOthersOnDeactivation]
                    )
                    return nil
                } catch {
                    return .failedToActivateAudioSession(error)
                }
            #else
                return nil
            #endif
        }

        class func deactivateAudioSession() -> OperationError? {
            #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
                do {
                    try Self.audioSession.setActive(
                        false,
                        options: [.notifyOthersOnDeactivation]
                    )
                    return nil
                } catch {
                    return .failedToDeactivateAudioSession(error)
                }
            #else
                return nil
            #endif
        }
    }
#endif

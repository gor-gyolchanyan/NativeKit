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

        /// Determines whether or not capturing is in progress.
        public var isCapturing: Bool {
            captureSession.isRunning
        }

        /// Determines whether or not a recording session is in progress.
        public var isRecording: Bool {
            mediaFileOutput.isRecording
        }

        /// Determines whether or not audio recording is enabled.
        public var isAudioEnabled: Bool {
            get {
                audioCaptureDeviceInput.ports.allSatisfy(\.isEnabled)
            }

            set(isAudioEnabled) {
                captureSession.beginConfiguration()
                audioCaptureDeviceInput.ports.forEach { $0.isEnabled = isAudioEnabled }
                captureSession.commitConfiguration()
            }
        }

        /// Determines whether or not video recording is enabled.
        public var isVideoEnabled: Bool {
            get {
                videoCaptureDeviceInput.ports.allSatisfy(\.isEnabled)
            }

            set(isVideoEnabled) {
                captureSession.beginConfiguration()
                videoCaptureDeviceInput.ports.forEach { $0.isEnabled = isVideoEnabled }
                captureSession.commitConfiguration()
            }
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

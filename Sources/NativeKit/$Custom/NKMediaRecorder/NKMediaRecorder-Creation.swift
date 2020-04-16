//
// Introductory information can be found in the `README.md` file located in the root directory of this repository.
// Licensing information can be found in the `LICENSE` file located in the root directory of this repository.
//

#if os(macOS) || os(iOS)
    import AVFoundation

    extension NKMediaRecorder {

        // Exposed

        // Type: NKMediaRecorder
        // Topic: Creation

        /// Creates a `NKMediaRecorder`.
        ///
        /// - parameter mediaFile: The `MediaFile` to write the recording to. The path must contain a valid media file extension in order for the recording to work.
        public convenience init(mediaFile: URL) throws {
            let captureSession = Self.makeCaptureSession()

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

            let mediaFileOutput = Self.makeMediaFileOutput()

            guard captureSession.canAddOutput(mediaFileOutput) else {
                throw NKMediaRecorder.CreationError.unusableMediaFileOutput
            }
            captureSession.addOutput(mediaFileOutput)

            self.init(
                captureSession: captureSession,
                audioCaptureDevice: audioCaptureDevice,
                audioCaptureDeviceInput: audioCaptureDeviceInput,
                videoCaptureDevice: videoCaptureDevice,
                videoCaptureDeviceInput: videoCaptureDeviceInput,
                mediaFile: mediaFile,
                mediaFileOutput: mediaFileOutput
            )
        }

        // Concealed

        // Type: NKMediaRecorder
        // Topic: Creation

        #if os(iOS)
            typealias AudioSession = AVAudioSession
        #endif

        typealias CaptureSession = AVCaptureSession

        typealias CaptureDevice = AVCaptureDevice

        typealias CaptureDeviceInput = AVCaptureDeviceInput

        typealias CaptureMediaFileOutput = AVCaptureMovieFileOutput

        #if os(macOS) && targetEnvironment(macCatalyst) || os(iOS)
            class var audioSession: AudioSession {
                .sharedInstance()
            }
        #endif

        class func makeCaptureSession() -> CaptureSession {
            let session: CaptureSession
            session = .init()
            return session
        }

        class func makeAudioCaptureDevice() -> CaptureDevice? {
            guard let audioCaptureDevice =
                CaptureDevice.default(for: .audio)
            else {
                return nil
            }
            return audioCaptureDevice
        }

        class func makeAudioCaptureDeviceInput(device audioCaptureDevice: CaptureDevice) throws -> CaptureDeviceInput {
            let audioCaptureDeviceInput: CaptureDeviceInput
            audioCaptureDeviceInput = try .init(device: audioCaptureDevice)
            return audioCaptureDeviceInput
        }

        class func makeVideoCaptureDevice() -> CaptureDevice? {
            guard let videoCaptureDevice =
                CaptureDevice.default(for: .video)
            else {
                return nil
            }
            return videoCaptureDevice
        }

        class func makeVideoCaptureDeviceInput(device videoCaptureDevice: CaptureDevice) throws -> CaptureDeviceInput {
            let videoCaptureDeviceInput: CaptureDeviceInput
            videoCaptureDeviceInput = try .init(device: videoCaptureDevice)
            return videoCaptureDeviceInput
        }

        class func makeMediaFileOutput() -> CaptureMediaFileOutput {
            let mediaFileOutput: CaptureMediaFileOutput
            mediaFileOutput = .init()
            return mediaFileOutput
        }
    }
#endif

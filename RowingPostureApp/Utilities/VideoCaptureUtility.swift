//
//  VideoCaptureUtility.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 27/08/2020.
//

import AVFoundation
import CoreVideo
import UIKit
import VideoToolbox

protocol VideoCaptureDelegate: AnyObject {
    func videoCapture(_ videoCapture: VideoCapture, didCaptureFrame capturedImage: CGImage?)
}

class VideoCapture: NSObject {
    
    enum VideoCaptureError: Error {
        case captureSessionMissing
        case invalidInput
        case invalidOutput
        case unknown
    }
    
    // Used to recieve captured frames.
    weak var delegate: VideoCaptureDelegate?
    
    let captureSession = AVCaptureSession()
    
    // Records video and allows access to the video frames.
    let videoOutput = AVCaptureVideoDataOutput()
    
    private(set) var cameraPosition = AVCaptureDevice.Position.back
    
    // Processes camera set up and frame capture.
    private let sessionQueue = DispatchQueue (
        label: "com.RowingPostureApp"
    )
    
    // To toggle between cameras.
    public func flipCamera(completion: @escaping (Error?) -> Void) {
        
    }
    
    // Setting up capture session.
    public func setupAVCapture(completion: @escaping (Error?) -> Void) {
        sessionQueue.async {
            do {
                try self.setupAVCapture()
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }
    
    public func setupAVCapture() throws {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .hd1280x720
        
        try setCaptureSessionInput()
        try setCaptureSessionOutput()
        
        captureSession.commitConfiguration()
    }
    
    private func setCaptureSessionInput() throws {
        
        guard let captureDevice = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: cameraPosition) else {
                throw VideoCaptureError.invalidInput
        }
        
        // Remove the current or any existing inputs.
        captureSession.inputs.forEach { input in
            captureSession.removeInput(input)
        }
        
        // An instance of the AVCaptureDeviceInput is created to capture the data recieved from the device.
        guard let videoInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            throw VideoCaptureError.invalidInput
        }
        
        // checks if there is a video input, else error.
        guard captureSession.canAddInput(videoInput) else {
            throw VideoCaptureError.invalidInput
        }
        
        captureSession.addInput(videoInput)
    }
    
    private func setCaptureSessionOutput() throws {
        
        // If there are previous outputs, remove them.
        captureSession.outputs.forEach { output in
            captureSession.removeOutput(output)
        }
        
        // Pixel type is set here.
        let settings: [String: Any] = [
            String(kCVPixelBufferPixelFormatTypeKey):
                kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
        ]
        
        videoOutput.videoSettings = settings
        
        // Newer frames will be discarded whilst the dispatch queue is processing older frames.
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        guard captureSession.canAddOutput(videoOutput) else {
            throw VideoCaptureError.invalidOutput
        }
        
        captureSession.addOutput(videoOutput)
        
        // The video orientation will be updated here.
        if let connection = videoOutput.connection(with: .video), connection.isVideoOrientationSupported {
            connection.isVideoMirrored = cameraPosition == .front
        }
    }
    
    // Frame capture will begin with these functions.
    // Notes state that this is to be performed on the main thread for speed purposes.
    
    public func startCaptureSession(competion: (() -> Void)? = nil) {
        sessionQueue.async {
            if !self.captureSession.isRunning {
                
                // This is called to start the data from between the inputs and outputs.
                self.captureSession.startRunning()
            }
            
            if let completionHandler = competion {
                DispatchQueue.main.async {
                    completionHandler()
                }
            }
        }
    }
    
    // Ending capture session.
    // Also to be performed on the main thread for speed purposes.
    
    public func stopCaptureSession(completion: (() -> Void)? = nil) {
        sessionQueue.async {
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
        
        if let completionHandler = completion {
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}

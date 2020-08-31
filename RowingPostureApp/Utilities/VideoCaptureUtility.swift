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
    func videoCapture(_ videoCapture: VideoCapture, didCaptureFrame image: CGImage?)
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
    let videoOutput = AVCaptureSession()
    
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
        captureSession.sessionPreset = .vga640x480
        
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
    }
}

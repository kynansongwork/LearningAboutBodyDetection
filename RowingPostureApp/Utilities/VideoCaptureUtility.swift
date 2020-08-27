//
//  VideoCaptureUtility.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 27/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
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
        label: "com.xdesign.RowingPostureApp"
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
        
    }
    
    private func setCaptureSessionOutput() throws {
        
    }
}

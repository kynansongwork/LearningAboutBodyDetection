//
//  VideoCaptureUtilityExtension.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import AVFoundation
import CoreVideo
import UIKit
import VideoToolbox

extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer,
                              from connection: AVCaptureConnection) {
        
        guard let delegate = delegate else { return }
        
        if let pixelBuffer = sampleBuffer.imageBuffer {
            // Locking the image buffer to access the memory. (trying)
            guard CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly) == kCVReturnSuccess
                else {
                    return
            }
            
            // Core graphics placeholder created here.
            var image: CGImage?
            
            // A bitmap image will be created from the pixel buffer.
            VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &image)
            
            // Releasing the image buffer.
            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
            
            DispatchQueue.main.async {
                delegate.videoCapture(self, didCaptureFrame: image)
            }
        }
    }
}

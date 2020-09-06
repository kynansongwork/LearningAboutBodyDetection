//
//  VideoCaptureUtilityExtension.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//

import AVFoundation
import CoreVideo
import UIKit
import VideoToolbox

extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer,
                              from connection: AVCaptureConnection) {
        
        guard let delegate = delegate else { return }
        
        // Getting the images underlying image data. Docs state not to manipulate the contents due to issues
        // with rendering that may happen.
        if let pixelBuffer = sampleBuffer.imageBuffer {
            // Locking the image buffer to access the memory. (trying)
            guard CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly) == kCVReturnSuccess
                else {
                    return
            }
            
            // Core graphics placeholder created here.
            var image: CGImage?
            
            // A bitmap image will be created from the pixel buffer. Core graphics is used to create the
            // bitmap image.
            VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &image)
            
            // Releasing the image buffer.
            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
            
            DispatchQueue.main.async {
                delegate.videoCapture(self, didCaptureFrame: image)
            }
        }
    }
}

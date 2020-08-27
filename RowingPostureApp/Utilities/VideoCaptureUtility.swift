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
}

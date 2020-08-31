//
//  AVCaptureVideoOrientation.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import AVFoundation
import UIKit

extension AVCaptureVideoOrientation {
    init(deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .landscapeLeft:
            self = .landscapeLeft
        case .portrait:
            self = .portrait
        case .portraitUpsideDown:
            self = .portraitUpsideDown
        case .landscapeRight:
            self = .landscapeRight
        default:
            self = .portrait
        }
    }
}

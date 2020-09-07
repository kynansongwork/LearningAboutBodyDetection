//
//  VideoCaptureViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 28/08/2020.
//

import UIKit
import AVFoundation

class VideoCaptureViewController: UIViewController, StoryboardLoadedViewController {
    
    var viewModel: VideoCaptureViewModel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var recordButton: RoundButton!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var cameraView: UIView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCloseButton()
        setUpCamera()
    }
    
    func setUpCamera() {
        cameraView.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        viewModel.coordinator?.dismiss()
    }
    
    func setUpCloseButton() {
        let buttonImage = UIImage(named: "icClose")
        let whiteImage = buttonImage?.withRenderingMode(.alwaysTemplate)
        closeButton.setImage(whiteImage, for: .normal)
        closeButton.tintColor = .white
        closeButton.accessibilityIdentifier = "icClose"
        closeButton.isAccessibilityElement = true
    }
}

extension VideoCaptureViewController: PoseNetModelDelegate {
    
    func poseNetModel(_ poseNet: PoseNetModel, didPredict predictions: PoseNetOutput) {
        
        // defer is used to execute code before moving to the next order of actions.
        // In cases of multiple defers, the functions will run in reverse order of their execution.
        defer {
            <#deferred statements#>
        }
    }
    
    
}

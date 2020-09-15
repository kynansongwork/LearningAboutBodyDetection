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

    @IBOutlet weak var poseImageView: PoseImageView!
    
    private let videoCapture = VideoCapture()
    private var poseNet: PoseNetModel!
    
    // Frame that is being used by the PoseNet model to make predictions.
    private var currentFrame: CGImage?
    
    // Algorithm used to extract poses from the frame.
    private var algorithm: Algorithm = .single
    private var poseBuilderConfig = PoseBuilderConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCloseButton()
        setUpCamera()
        self.videoCapture.startCaptureSession()
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Instatiate the model.
        do {
            poseNet = try PoseNetModel()
        } catch {
            fatalError("Failed to load model: \(error.localizedDescription).")
        }
        
        poseNet.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        videoCapture.stopCaptureSession()
    }
    
    func setUpCamera() {
        
        videoCapture.setupAVCapture { error in 
            if let error = error {
                print("The camera failed with: \(error)")
                return
            }
            
            self.videoCapture.delegate = self
            self.videoCapture.startCaptureSession()
        }
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        
        //When tapped, the record button will screen record.
        print("Record Tapped.")
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

extension VideoCaptureViewController: VideoCaptureDelegate {
    
    func videoCapture(_ videoCapture: VideoCapture, didCaptureFrame capturedImage: CGImage?) {
        
        guard currentFrame == nil else {
            return
        }
        
        guard let image = capturedImage else {
            fatalError("Image was null")
        }
        
        currentFrame = image
        poseNet.predict(image: image)
    }
}

extension VideoCaptureViewController: PoseNetModelDelegate {
    
    func poseNetModel(_ poseNet: PoseNetModel, didPredict predictions: PoseNetOutput) {
        
        // defer is used to execute code before moving to the next order of actions.
        // In cases of multiple defers, the functions will run in reverse order of their execution.
        defer {
            // Used to release the current frame once this method is complete.
            self.currentFrame = nil
        }
        
        guard let currentFrame = currentFrame else {
            return
        }
        
        let poseBuilder = PoseBuilder(output: predictions, configuration: poseBuilderConfig, inputImage: currentFrame)
        
        // For multiple poses.
        // let poses = algorithm == .single ? [poseBuilder.pose] : poseBuilder.poses
        
        let poses = [poseBuilder.pose]
        
        poseImageView.show(poses: poses, on: currentFrame)
    }
    
    
}

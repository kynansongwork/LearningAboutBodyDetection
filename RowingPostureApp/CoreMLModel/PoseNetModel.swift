//
//  PoseNetModel.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 10/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import CoreML
import Vision

protocol PoseNetModelDelegate: AnyObject {
    func poseNetModel(_ poseNet: PoseNetModel, didPredict predictions: PoseNetOutput)
}

class PoseNetModel {
    
    weak var delegate: PoseNetModelDelegate?
    
    let inputSize = CGSize(width: 513, height: 513)
    
    // Valid strides are 16 and 8, they define the resolution of the grid output of the model.
    // Smaller strides allow higher resolution grids and increased accuracy, but require more computation power.
    let outputStride = 16
    
    private let poseNetMLModel: MLModel
    
    init() throws {
        poseNetMLModel = try PoseNetMobileNet075S16FP16(configuration: .init()).model
    }
    
    // By using prediction from the PoseNetModel, the outputs are returned to the assigned delegate
    func predict(image: CGImage) {
        //qos = quality of service
        DispatchQueue.global(qos: .userInitiated).async {
            //The image is wrapped in an instance of the PoseNet input to be resized and sent
            //to the model.
            
            let input = PoseNetInput(image: image, size: self.inputSize)
            
            guard let prediction = try? self.poseNetMLModel.prediction(from: input) else {
                return
            }
            
            let poseNetOutput = PoseNetOutput(prediction: prediction,
                                              modelInputSize: self.inputSize,
                                              modelOutputStride: self.outputStride)
            
            DispatchQueue.main.async {
                self.delegate?.poseNetModel(self, didPredict: poseNetOutput)
            }
        }
    }
}

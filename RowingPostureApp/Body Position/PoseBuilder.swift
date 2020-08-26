//
//  PoseBuilder.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 25/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import CoreGraphics

struct PoseBuilder {
    
    // Prediction outputs are analysed to find the construct poses.
    let output: PoseNetOutput
    
    // Transformation matrix is used to map the joints from the PoseNet model's input image onto the original image.
    let modelToInputTransformation: CGAffineTransform
    
    // The parameters the Pose Bulder uses in the pose algorithms.
    var configuration: PoseBuilderConfiguration
    
    init(output: PoseNetOutput, configuration: PoseBuilderConfiguration, inputImage: CGImage) {
        self.output = output
        self.configuration = configuration
        
        // Used to transform joint positions back into the space of the original input size.
        modelToInputTransformation = CGAffineTransform(
            scaleX: inputImage.size.width / output.modelInputSize.width,
            y: inputImage.size.height /  output.modelInputSize.height)
    }
}

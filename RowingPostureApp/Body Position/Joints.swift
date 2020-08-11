//
//  Joints.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 10/08/2020.
// Based off PoseFinder App
//  Copyright © 2020 xDesign. All rights reserved.
//

import CoreGraphics

class Joint {
    
    enum JointName: Int, CaseIterable {
        case nose
        case leftEye
        case rightEye
        case leftEar
        case rightEar
        case leftShoulder
        case rightShoulder
        case leftElbow
        case rightElbow
        case leftWrist
        case rightWrist
        case leftHip
        case rightHip
        case leftKnee
        case rightKnee
        case leftAnkle
        case rightAnkle
    }
    
    // Number of available joints
    static var numberOfJoints: Int {
        return JointName.allCases.count
    }
    
    let jointName: JointName
    
    // Poistion of the joint relative to the input image, then mapped to original image.
    var jointPosition: CGPoint
    
    // Joint's respective cell index based on model's output grid.
    var cellIndex: PoseNetOutput.Cell
    
    //Confidence score associated with joint. The level of certainty of the joint postion in the image. Found via the heatmap array in PoseNet model.
    var confidence: Double
    
    // To indicate whether the confidence level has been met
    var isValid: Bool
    
    init(name: JointName,
         cell: PoseNetOutput.cell = .zero,
         jointPosition: CGPoint = .zero,
         confidence: Double = 0,
         isValid: Bool = false) {
        self.jointName = name
        self.cellIndex = cell
        self.jointPosition = jointPosition
        self.confidence = confidence
        self.isValid = isValid
    }
    
}

//
//  PoseBuilderExtensionSingle.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 26/08/2020.
//

import CoreGraphics

extension PoseBuilder {
    
    // The PoseNet model returns a pose constructed based on its outputs.
    var pose: Pose {
        var pose = Pose()
        
        // Iterates over the joints to find the most likely position and associated confidence level
        // via querying the heatmap array for the cell with the greatest confidence.
        // This is used to ascertain its position.
        pose.joints.values.forEach { joint in
            configure(joint: joint)
        }
        
        // Compute and assign the level of confidence for the pose.
        pose.confidence = pose.joints.values.map {
            $0.confidence
        }.reduce(0, +) / Double(Joint.numberOfJoints)
        
        // The joints are mapped to positions on the original image.
        pose.joints.values.forEach { joint in
            joint.jointPosition = joint.jointPosition.applying(modelToInputTransformation)
        }
        
        return pose
    }
    
    // The joint's properties are set by using the the associated cell with the greated confidence.
    // The level of confidence is gained through the use of the heatmap array output from the PoseNet model.
    private func configure(joint: Joint) {
        // A loop is used to iterate over the maps associated joints to find the cell with the highest level
        // of confidence.
        var bestCell = PoseNetOutput.Cell(0,0)
        var bestConfidence = 0.0
        
        for yIndex in 0..<output.height {
            for xIndex in 0..<output.width {
                let currentCell = PoseNetOutput.Cell(yIndex, xIndex)
                let currentConfidence = output.confidence(for: joint.jointName, at: currentCell)
                
                // Monitor the cell with the greatest confidence.
                if currentConfidence > bestConfidence {
                    bestConfidence = currentConfidence
                    bestCell = currentCell
                }
            }
            
            // Once found, update the joint.
            joint.cellIndex = bestCell
            joint.jointPosition = output.position(for: joint.jointName, at: joint.cellIndex)
            joint.confidence = bestConfidence
            joint.isValid = joint.confidence >= configuration.jointConfidenceThreshold
        }
    }
}

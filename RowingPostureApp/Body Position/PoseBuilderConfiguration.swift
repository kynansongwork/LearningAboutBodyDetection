//
//  PoseBuilderConfiguration.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 26/08/2020.
//

import CoreGraphics

enum Algorithm: Int {
    // for single or multiple figure estimations.
    case single
    case multiple
}

struct PoseBuilderConfiguration {
    
    // Minimum valid value for joints in a pose.
    var jointConfidenceThreshold = 0.1
    
    // Minimum value for a valid pose.
    var poseConfidenceThreshold = 0.5
    
    // The minimum distance between two distinct joints of the same type. i.e. hips and hips.
    // This is mainly for multiple poses in the capture.
    var matchingJointDistance = 40.0
    
    // Search radius when checking for a joint. Aims to determine if a joing has the greatest confidence
    // amongst its neighbours.
    // Used for multiple poses.
    var localSearchRadius = 3
    
    // Maximum number of poses returned.
    var maxPoseCount = 15
    
    // Iterations performed to refine the position of an adjacent joint.
    var adjacentJointOffsetRefinementSteps = 3
}

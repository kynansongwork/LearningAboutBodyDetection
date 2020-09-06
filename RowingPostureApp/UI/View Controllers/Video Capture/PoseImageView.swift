//
//  PoseImageView.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 06/09/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit


// This view is used to visialise the etected pose by rendering the joints and connections.
@IBDesignable
class PoseImageView: UIImageView {
    
    // This struct is used to describe the connections between two related joints.
    struct JointSegment {
        let jointA: Joint.JointName
        let jointB: Joint.JointName
    }
    
    // This array is composed of all the joint pairs that will go towards creating the wireframe of the connected
    // joints to create a fully rendered 'pose'.
    
    static let jointSegments = [
        
        JointSegment(jointA: .leftHip, jointB: .leftShoulder),
        JointSegment(jointA: .leftShoulder, jointB: .leftElbow),
        JointSegment(jointA: .leftElbow, jointB: .leftWrist),
        JointSegment(jointA: .leftHip, jointB: .leftKnee),
        JointSegment(jointA: .leftKnee, jointB: .leftAnkle),
        JointSegment(jointA: .rightHip, jointB: .rightShoulder),
        JointSegment(jointA: .rightShoulder, jointB: .rightElbow),
        JointSegment(jointA: .rightElbow, jointB: .rightWrist),
        JointSegment(jointA: .rightHip, jointB: .rightKnee),
        JointSegment(jointA: .rightKnee, jointB: .rightAnkle),
        JointSegment(jointA: .leftShoulder, jointB: .rightShoulder),
        JointSegment(jointA: .leftHip, jointB: .rightHip)
    ]
}

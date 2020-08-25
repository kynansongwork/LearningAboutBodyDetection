//
//  Pose.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 21/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import CoreGraphics

struct Pose {
    
    // Parent child relationship between joints.
    struct Edge {
        let index: Int
        let parent: Joint.JointName
        let child: Joint.JointName
        
        init(from parent: Joint.JointName, to child: Joint.JointName, index: Int) {
            self.index = index
            self.parent = parent
            self.child = child
        }
    }
    
    // Definition of the joint connections.
    // The index is used to access the associated value in the displacement maps output from the model.
    static let edges = [
        Edge(from: .nose, to: .leftEye, index: 0),
        Edge(from: .leftEye, to: .leftEar, index: 1),
        Edge(from: .nose, to: .rightEye, index: 2),
        Edge(from: .rightEye, to: .rightEar, index: 3),
        Edge(from: .nose, to: .leftShoulder, index: 4),
        Edge(from: .leftShoulder, to: .leftElbow, index: 5),
        Edge(from: .leftElbow, to: .leftWrist, index: 6),
        Edge(from: .leftShoulder, to: .leftHip, index: 7),
        Edge(from: .leftHip, to: .leftKnee, index: 8),
        Edge(from: .leftKnee, to: .leftAnkle, index: 9),
        Edge(from: .nose, to: .rightShoulder, index: 10),
        Edge(from: .rightShoulder, to: .rightElbow, index: 11),
        Edge(from: .rightElbow, to: .rightWrist, index: 12),
        Edge(from: .rightShoulder, to: .rightHip, index: 13),
        Edge(from: .rightHip, to: .rightKnee, index: 14),
        Edge(from: .rightKnee, to: .rightAnkle, index: 15),
    ]
    
    // Joints that make the pose.
    private(set) var joints: [Joint.JointName: Joint] = [
        .nose: Joint(name: .nose),
        .leftEye: Joint(name: .leftEye),
        .leftEar: Joint(name: .leftEar),
        .leftShoulder: Joint(name: .leftShoulder),
        .leftElbow: Joint(name: .leftElbow),
        .leftWrist: Joint(name: .leftWrist),
        .leftHip: Joint(name: .leftHip),
        .leftKnee: Joint(name: .leftKnee),
        .leftAnkle: Joint(name: .leftAnkle),
        .rightEye: Joint(name: .rightEye),
        .rightEar: Joint(name: .rightEar),
        .rightShoulder: Joint(name: .rightShoulder),
        .rightElbow: Joint(name: .rightElbow),
        .rightWrist: Joint(name: .rightWrist),
        .rightHip: Joint(name: .rightHip),
        .rightKnee: Joint(name: .rightKnee),
        .rightAnkle: Joint(name: .rightAnkle)
    ]
    
    // Confidence score of each pose
    var confidence: Double = 0.0
    
    // Subscript is used to retrieve values by index.
    subscript(jointName: Joint.JointName) -> Joint {
        get {
            assert(joints[jointName] != nil)
            return joints[jointName]!
        }
        set {
            joints[jointName] = newValue
        }
    }
    
    // This function returns the edges to/from the specified point/ joint via filtering the edge array.
    static func edges(for jointName: Joint.JointName) -> [Edge] {
        return Pose.edges.filter {
            $0.parent == jointName || $0.child == jointName
        }
    }
    
    // This function will return the edge that meets the specified parent and child joint names.
    // The edge returned will connect the two argouments.
    static func edge(from parentJointName: Joint.JointName, to childJointName: Joint.JointName) -> Edge? {
        return Pose.edges.first(where: { $0.parent == parentJointName && $0.child == childJointName})
    }
}

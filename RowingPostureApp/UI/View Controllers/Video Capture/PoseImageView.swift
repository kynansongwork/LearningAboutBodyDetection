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
    
    // Setting up how the connecting lines between joints will look.
    
    @IBInspectable var segmentLineWidth: CGFloat = 2
    @IBInspectable var segmentColour: UIColor = UIColor.systemTeal
    
    // Circles at the joint points.
    
    @IBInspectable var jointRadius: CGFloat = 4
    @IBInspectable var jointColour: UIColor = UIColor.systemRed
    
    // This method is used to render the image of the pose.
    // It takes an array of Poses that have been detected, and a frame is the image that has been used
    // to detect the poses. It is then used as the background of the returned image that contains the rendered poses.
    
    func show(poses: [Pose], on frame: CGImage) {
        
        let imageSize = CGSize(width: frame.width, height: frame.height)
        
        //  Determines the attributes of the core graphics context created by the image renderer.
        let imageFormat = UIGraphicsImageRendererFormat()
        imageFormat.scale = 1
        
        let renderer = UIGraphicsImageRenderer(size: imageSize, format: imageFormat)
        
        let renderedImage = renderer.image { rendererContext in
            
            // The current frame is used as the background for the newly drawn image of the poses.
            drawPoses(image: frame, in: rendererContext.cgContext)
            
            // A loop is used to access each joined segment to draw the lines between them.
            for pose in poses {
                for segment in PoseImageView.jointSegments {
                    let jointA = pose[segment.jointA]
                    let jointB = pose[segment.jointB]
                    
                    guard jointA.isValid, jointB.isValid else {
                        
                        // continue is used to direct the for loop to start again, but from the
                        // beginning of the next iteration of the loop. Progresses the loop incrementally.
                        continue
                    }
                    
                    drawLine(from: jointA, to: jointB, in: rendererContext.cgContext)
                }
                
                // Loop through the valid joints and draw circles above the segment lines where necessary.
                for joint in pose.joints.values.filter( { $0.isValid } ) {
                    drawCircles(circle: joint, in: rendererContext.cgContext)
                }
            }
        }
        
        image = renderedImage
    }
    
    // This method will flip and then draw the given image.
    // The arguments taken are the image that will be drawn onto the context and the rendering context.
    func drawPoses(image: CGImage, in cgContext: CGContext) {
        
        // Created and pushes a copy of the current graphic state onto the stack to provide context.
        cgContext.saveGState()
        
        // The context will be flipped prior to image rendering as the image passed in will be assumed to be flipped.
        // Back ground image won't render when scale removed.
        cgContext.scaleBy(x: 1.0, y: -1.0)
        
        // Next the rendered image is adjusted for the scale changes made.
        let drawingRect = CGRect(x: 0, y: -image.height, width: image.width, height: image.height)
        cgContext.draw(image, in: drawingRect)
        
        // Sets the current graphics state to the most recently saved.
        cgContext.restoreGState()
    }
    
    // A circle is drawn at a given/valid point.
    func drawCircles(circle joint: Joint, in cgContext: CGContext) {
        
        cgContext.setFillColor(jointColour.cgColor)
        
        let rectangle = CGRect(x: joint.jointPosition.x - jointRadius, y: joint.jointPosition.y - jointRadius,
                               width: jointRadius * 2, height: jointRadius * 2)
        // Adds an elipse that will fit in a set rectangle.
        cgContext.addEllipse(in: rectangle)
        cgContext.drawPath(using: .fill)
    }
    
    // Method to render the connection between joint pairs.
    // The parameters used are the parent and child joints which represent the start and end of the drawn line.
    // cgContext will provide the rendering context.
    func drawLine(from parentJoint: Joint, to childJoint: Joint, in cgContext: CGContext) {
        
        cgContext.setStrokeColor(segmentColour.cgColor)
        cgContext.setLineWidth(segmentLineWidth)
        
        // Drawing the line from point to point.
        cgContext.move(to: parentJoint.jointPosition)
        cgContext.addLine(to: childJoint.jointPosition)
        cgContext.strokePath()
    }
}

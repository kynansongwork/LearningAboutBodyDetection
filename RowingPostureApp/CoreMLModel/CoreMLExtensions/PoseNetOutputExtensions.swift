//
//  PoseNetOutputExtensions.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 11/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import CoreML
import Vision

extension PoseNetOutput {
    
    // Determines the postion for a joint type at a specific grid cell.
    //  The y and x indices are multiplied by the output stride, then adding he associated offset.
    func position(for jointName: Joint.JointName, at cell: Cell) -> CGPoint {
        let jointOffset = offset(for: jointName, at: cell)
        
        var jointPosition = CGPoint(x: cell.xIndex * modelOutputStride,
                                    y: cell.yIndex * modelOutputStride)
        
        // The offset is added to get a precise position.
        // Uses the += static function in CGPoint extensions.
        jointPosition += jointOffset
        
        return jointPosition
    }

    // From the position, the mapped cell index is returned.
    func cell(for position: CGPoint) -> Cell? {
        let yIndex = Int((position.y / CGFloat(modelOutputStride)).rounded())
        let xIndex = Int((position.x / CGFloat(modelOutputStride)).rounded())
        
        guard yIndex >= 0 && yIndex < height && xIndex >= 0 && xIndex < width  else {
            return nil
        }
        
        return Cell(yIndex, xIndex)
    }
    
    // Returns the offset for a joint at a specific cell index.
    func offset(for jointName: Joint.JointName, at cell: Cell) -> CGVector {
        // JointName is the index for the first dimension of the offsets array.
        // Cell is the coordinates for the given joint.
        
        // Using the y and x components of the offset, an index can be created.
        let yOffsetIndex = [jointName.rawValue, cell.yIndex, cell.xIndex]
        // Used to determine the vertical component.
        
        let xOffsetIndex = [jointName.rawValue + Joint.numberOfJoints, cell.yIndex, cell.xIndex]
        // Used to determine the horizontal component.
        
        // Getting the y and x components from the offset array.
        let offsetY: Double = offsets[yOffsetIndex].doubleValue
        let offsetX: Double = offsets[xOffsetIndex].doubleValue
        
        return CGVector(dx: CGFloat(offsetX), dy: CGFloat(offsetY))
    }
    
    // Used to return the confidence level of a joint at a specific index.
    func confidence(for jointName: Joint.JointName, at cell: Cell) -> Double {
        
        let multiArryIndex = [jointName.rawValue, cell.yIndex, cell.xIndex]
        // Used to find the joints associated confidence value in the heatmap array.
        
        return heatmap[multiArryIndex].doubleValue
    }
    
// TODO: Make this into one function once verified that it I can run this app.
    
    //The displacement vectors for an edge and index at a specific point.
    func forwardDisplacement(for edgeIndex: Int, at cell: Cell) -> CGVector {
        // edge index is the first dimension of the forawrdDisplacementMap array.
        // cell is the coordinates for the arrays output for the given edge.
        
        //Creating the multi array index.
        let yEdgeIndex = [edgeIndex, cell.yIndex, cell.xIndex]
        let xEdgeIndex = [edgeIndex + Pose.edges.count, cell.yIndex, cell.xIndex]
        
        // Getting the displacements from the multi array.
        let displacementY = forwardDisplacementMap[yEdgeIndex].doubleValue
        let displacementX = forwardDisplacementMap[xEdgeIndex].doubleValue
        
        return CGVector(dx: displacementX, dy: displacementY)
    }
    
    func backwardDisplacement(for edgeIndex: Int, at cell: Cell) -> CGVector {
        let yEdgeIndex = [edgeIndex, cell.yIndex, cell.xIndex]
        let xEdgeIndex = [edgeIndex + Pose.edges.count, cell.yIndex, cell.xIndex]
        
        let displacementY = backwardDisplacementMap[yEdgeIndex].doubleValue
        let displacementX = backwardDisplacementMap[xEdgeIndex].doubleValue
        
        return CGVector(dx: displacementX, dy: displacementY)
    }
}

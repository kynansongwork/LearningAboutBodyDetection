//
//  PoseNetOutput.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 11/08/2020.
//

import CoreML
import Vision

struct PoseNetOutput {
    enum Feature: String {
        case heatmap = "heatmap"
        case offsets = "offsets"
        case backwardDisplacementMap = "displacementBwd"
        case forwardDisplacementMap = "displacementFwd"
    }
    
    // Outputs are arranged into a grid, and each cell in the grid is a region of pixels.
    // Each side of the region is the outputStride pixels of the input image.
    // This is all used to create a structure with index based coordinates which are used to query
    // the models outputs.
    struct Cell {
        let yIndex: Int
        let xIndex: Int
        
        init(_ yIndex: Int, _ xIndex: Int) {
            self.yIndex = yIndex
            self.xIndex = xIndex
        }
        
        static var zero: Cell {
            return Cell(0,0)
        }
    }
    
    // The detection confidence for each joint is stored in a multidimensional array based on the heatmap in the model.
    // The joint in the array is the index of the detected joit followed by the grid cell indices.
    let heatmap: MLMultiArray
    
    // The next array used, will store the offset for each joint.
    let offsets: MLMultiArray
    
    // Next the displacement vectors that connect a joint to it's parent are stored.
    // In this array, edges are stored, where the edge is the index of the joint pair, followed by the grid cell indices.
    let backwardDisplacementMap: MLMultiArray
    let forwardDisplacementMap: MLMultiArray
    // These are used when detecting multiple poses, however for the purpose of my app, these will not be used, but are kept in for learning.
    
    // 257x257, 353x353, 513x513
    let modelInputSize: CGSize
    
    let modelOutputStride: Int
    
    var height: Int {
        return heatmap.shape[1].intValue
        // returns the height of of the output array.
    }
    
    var width: Int {
        return heatmap.shape[2].intValue
        // returns the width of of the output array.
    }
    
    init(prediction: MLFeatureProvider, modelInputSize: CGSize, modelOutputStride: Int) {
        // MLFeatureProvider is an interface for a collection of values that represent the models input or output.

        guard let heatmap = prediction.multiArrayValue(for: .heatmap) else {
            fatalError("Failed to get heatmap array")
        }
        guard let offsets = prediction.multiArrayValue(for: .offsets) else {
            fatalError("Failed to get offsets array")
        }
        guard let backwardDisplacementMap = prediction.multiArrayValue(for: .backwardDisplacementMap) else {
            fatalError("Failed to get backwardDisplacementMap array")
        }
        guard let forwardDisplacementMap = prediction.multiArrayValue(for: .forwardDisplacementMap) else {
            fatalError("Failed to get forwardDisplacementMap array")
        }
        
        self.heatmap = heatmap
        self.offsets = offsets
        self.backwardDisplacementMap = backwardDisplacementMap
        self.forwardDisplacementMap = forwardDisplacementMap
        
        self.modelInputSize = modelInputSize
        self.modelOutputStride = modelOutputStride
    }
}

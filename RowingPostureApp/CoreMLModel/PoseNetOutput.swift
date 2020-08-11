//
//  PoseNetOutput.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 11/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
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
}

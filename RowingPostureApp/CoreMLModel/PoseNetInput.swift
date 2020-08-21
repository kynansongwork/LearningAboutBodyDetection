//
//  PoseNetInput.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 11/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import CoreML
import Vision

class PoseNetInput: MLFeatureProvider {
    
    private static let imageFeatureName = "image"
    
    // The original image taken and used.
    var imageFeature: CGImage
    
    // The feature provider is used to resize the imageFeature through cropping and resizing
    // via the featureValue method.
    let imageFeatureSize: CGSize
    
    var featureNames: Set<String> {
        return [PoseNetInput.imageFeatureName]
    }
    
    init(image: CGImage, size: CGSize) {
        imageFeature = image
        imageFeatureSize = size
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        guard featureName == PoseNetInput.imageFeatureName else {
            return nil
        }
        
        let options: [MLFeatureValue.ImageOption: Any] = [
            .cropAndScale : VNImageCropAndScaleOption.scaleFill.rawValue
        ]
        
        return try? MLFeatureValue(cgImage: imageFeature,
                                   pixelsWide: Int(imageFeatureSize.width),
                                   pixelsHigh: Int(imageFeatureSize.height),
                                   pixelFormatType: imageFeature.pixelFormatInfo.rawValue,
                                   options: options)
    }
    
    
}

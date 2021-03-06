//
//  MLFeatureProviderExtensions.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 11/08/2020.
//

import CoreML

extension MLFeatureProvider {
    func multiArrayValue(for feature: PoseNetOutput.Feature) -> MLMultiArray? {
        // Feature enum is passed in and an array with the corresponding 'type' is returned.
        return featureValue(for: feature.rawValue)?.multiArrayValue
    }
}

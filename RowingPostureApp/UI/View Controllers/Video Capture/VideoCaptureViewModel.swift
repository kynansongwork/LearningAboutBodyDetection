//
//  VideoCaptureViewModel.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 28/08/2020.
//

import Foundation
import Combine

class VideoCaptureViewModel: BaseViewModel {
    
    let confidenceConfigurations = UserDefaults.standard
    
    func getConfigurations() -> PoseBuilderConfiguration {
        
        var settings: PoseBuilderConfiguration?
        
        guard let savedSettings = confidenceConfigurations.object(forKey: "currentSettings") as? Data else { return PoseBuilderConfiguration() }
        
        let decoder = JSONDecoder()
        if let loadedSettings = try? decoder.decode(Settings.self, from: savedSettings) {
            settings?.jointConfidenceThreshold = loadedSettings.jointConfidence
            settings?.poseConfidenceThreshold = loadedSettings.poseConfidence
            settings?.matchingJointDistance = loadedSettings.matchingMinimumDistance
            settings?.localSearchRadius = Int(loadedSettings.localSearchRadius)
            settings?.maxPoseCount = 1
            settings?.adjacentJointOffsetRefinementSteps = Int(loadedSettings.adjacentRefinementSteps)
        }
        
        return settings ?? PoseBuilderConfiguration()
    }
}

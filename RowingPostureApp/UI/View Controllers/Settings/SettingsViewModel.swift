//
//  SettingsViewModel.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//

import Foundation

class SettingsViewModel: BaseViewModel {
    
    let cells: [String] = [SettingsHeaders().jointConfidence,
                           SettingsHeaders().poseConfidence,
                           SettingsHeaders().localSearchRadius,
                           SettingsHeaders().matchingMinimumDistance,
                           SettingsHeaders().adjacentRefinementSteps]
    
}

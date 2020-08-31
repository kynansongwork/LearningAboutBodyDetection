//
//  SettingsViewModel.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import Foundation

class SettingsViewModel: BaseViewModel {
    
    let cells: [String] = [SettingsHeaders().jointConfidence,
                           SettingsHeaders().poseConfidence,
                           SettingsHeaders().localSearchRadius,
                           SettingsHeaders().matchingMinimumDistance,
                           SettingsHeaders().adjacentRefinementSteps]
    
}

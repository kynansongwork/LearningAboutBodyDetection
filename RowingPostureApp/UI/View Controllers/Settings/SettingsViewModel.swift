//
//  SettingsViewModel.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//

import Foundation

class SettingsViewModel: BaseViewModel {
    
    var blueToothHelper: BluetoothInterface
    var poseBuilderConfiguration = PoseBuilderConfiguration()
    
    var configuration: PoseBuilderConfiguration! {
        didSet {
            poseBuilderConfiguration = configuration
        }
    }
    
    let cells: [String] = [SettingsHeaders().jointConfidence,
                           SettingsHeaders().poseConfidence,
                           SettingsHeaders().localSearchRadius,
                           SettingsHeaders().matchingMinimumDistance,
                           SettingsHeaders().adjacentRefinementSteps,
                           SettingsHeaders().blueTooth]
    
    override init(coordinator: BaseCoordinator) {
        self.blueToothHelper = BluetoothHelper.shared
        super.init(coordinator: coordinator)
    }
    
    func scanForDevices() {
        blueToothHelper.scanForDevices()
    }
    
    func configureConfidenceLevels() {
        
    }
}

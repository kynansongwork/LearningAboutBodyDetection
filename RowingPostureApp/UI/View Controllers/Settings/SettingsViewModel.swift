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
        self.configuration = poseBuilderConfiguration
        super.init(coordinator: coordinator)
    }
    
    func scanForDevices() {
        blueToothHelper.scanForDevices()
    }
    
    func configureConfidenceLevels(sliderRow: Int, sliderValue: Int) {
        
        switch sliderRow {
        case 0:
            configuration.jointConfidenceThreshold = Double(sliderValue)
            print(configuration.jointConfidenceThreshold)
        case 1:
            configuration.poseConfidenceThreshold = Double(sliderValue)
        case 2:
            configuration.localSearchRadius = sliderValue
        case 3:
            configuration.matchingJointDistance = Double(sliderValue)
        case 4:
            configuration.adjacentJointOffsetRefinementSteps = sliderValue
        default:
            print("Unable to find configuration")
        }
    }
    
    func saveSettings() {
        //Save the settings to user defaults.
        let confidenceConfigurations = UserDefaults.standard
        confidenceConfigurations.set(configuration.jointConfidenceThreshold, forKey: "jointConfidence")
        confidenceConfigurations.set(configuration.poseConfidenceThreshold, forKey: "poseConfidence")
        confidenceConfigurations.set(configuration.localSearchRadius, forKey: "searchRadius")
        confidenceConfigurations.set(configuration.matchingJointDistance, forKey: "jointDistance")
        confidenceConfigurations.set(configuration.adjacentJointOffsetRefinementSteps, forKey: "jointOffset")
    }
}

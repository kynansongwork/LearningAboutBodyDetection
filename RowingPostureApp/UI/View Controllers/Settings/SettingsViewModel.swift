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
    let confidenceConfigurations = UserDefaults.standard
    
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
        let settingsStruct = Settings(jointConfidence: configuration.jointConfidenceThreshold, poseConfidence: configuration.poseConfidenceThreshold, localSearchRadius: Double(configuration.localSearchRadius), matchingMinimumDistance: configuration.matchingJointDistance, adjacentRefinementSteps: Double(configuration.adjacentJointOffsetRefinementSteps))
        
        let encoder = JSONEncoder()
        if let encodedSettings = try? encoder.encode(settingsStruct) {
            confidenceConfigurations.set(encodedSettings, forKey: "currentSettings")
        }
    }
    
    func loadSettings() {
        guard let savedSettings = confidenceConfigurations.object(forKey: "currentSettings") as? Data else { return }
        
        let decoder = JSONDecoder()
        if let loadedSettings = try? decoder.decode(Settings.self, from: savedSettings) {
            configureConfidenceLevels(sliderRow: 0, sliderValue: Int(loadedSettings.jointConfidence))
            configureConfidenceLevels(sliderRow: 1, sliderValue: Int(loadedSettings.poseConfidence))
            configureConfidenceLevels(sliderRow: 2, sliderValue: Int(loadedSettings.localSearchRadius))
            configureConfidenceLevels(sliderRow: 3, sliderValue: Int(loadedSettings.matchingMinimumDistance))
            configureConfidenceLevels(sliderRow: 4, sliderValue: Int(loadedSettings.adjacentRefinementSteps))
        }
    }
}

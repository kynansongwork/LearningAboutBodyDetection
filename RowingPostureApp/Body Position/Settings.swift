//
//  Settings.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//

import Foundation

struct Settings: Codable {
    var jointConfidence: Double
    var poseConfidence: Double
    var localSearchRadius: Double
    var matchingMinimumDistance: Double
    var adjacentRefinementSteps: Double
}

struct SettingsHeaders {
    let jointConfidence: String = "Joint confidence threshold"
    let poseConfidence: String = "Pose confidence threshold"
    let localSearchRadius: String = "Local joint search radius"
    let matchingMinimumDistance: String = "Matching joint minimum distance"
    let adjacentRefinementSteps: String = "Adjacent joint refinement steps"
    let blueTooth: String = "Bluetooth Settings"
}

//
//  SettingsViewModelTests.swift
//  RowingPostureAppTests
//
//  Created by Kynan Song on 07/11/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import XCTest
@testable import RowingPostureApp

class SettingsViewModelTests: XCTestCase {
    
    var settingsViewModel: SettingsViewModel?
    let coordinator = TestCoordinator()

    override func setUpWithError() throws {
        settingsViewModel = SettingsViewModel(coordinator: coordinator)
    }

    func testCanUpdateConfidenceLevels() throws {
        settingsViewModel?.configureConfidenceLevels(sliderRow: 1, sliderValue: 20)
        XCTAssertEqual(settingsViewModel?.configuration.poseConfidenceThreshold, 20)
    }
}

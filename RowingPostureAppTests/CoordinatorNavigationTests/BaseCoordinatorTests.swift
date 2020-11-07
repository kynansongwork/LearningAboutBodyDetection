//
//  BaseCoordinatorTests.swift
//  RowingPostureAppTests
//
//  Created by Kynan Song on 01/09/2020.
//

import XCTest
@testable import RowingPostureApp

class BaseCoordinatorTests: XCTestCase {

    func testCanPresentChildCoordinator() {
        let coordinator = TestCoordinator()
        let childCoordinator = TestCoordinator()
        
        XCTAssertNoThrow(try coordinator.present(childCoordinator))
        
        if let testController = coordinator.rootViewController as? TestViewController {
            XCTAssertTrue(testController.presentCalled)
        } else {
            XCTFail()
        }
    }
}

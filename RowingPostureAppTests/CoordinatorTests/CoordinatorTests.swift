//
//  CoordinatorTests.swift
//  RowingPostureAppTests
//
//  Created by Kynan Song on 01/09/2020.
//

import XCTest
@testable import RowingPostureApp

class CoordinatorTests: XCTestCase {

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

class TestCoordinator: BaseCoordinator {
    
    var parentCoordinator: BaseCoordinator?
    var childCoordinator: BaseCoordinator?
    var rootViewController: UIViewController
    
    let viewController: TestViewController
    
    required init() {
        viewController = TestViewController()
        self.rootViewController = viewController
        prepare()
    }
    
    func prepare() {
        viewController.viewModel?.coordinator = self
    }
    
    func transition(to page: TransitionRef, object: Any?) -> Bool {
        return true
    }
    
    func dismiss(_ completion: (() -> Void)?) {
        dismissInternal(completion)
    }
    
    func dismiss() {
        dismissInternal()
    }
    
}

class TestViewController: UIViewController, ModeledViewController {
    var viewModel: ViewModel!
    
    var dismissCalled = false
    var presentCalled = false
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        self.dismissCalled = true
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        self.presentCalled = true
    }
}

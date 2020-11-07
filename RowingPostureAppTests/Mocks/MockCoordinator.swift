//
//  MockCoordinator.swift
//  RowingPostureAppTests
//
//  Created by Kynan Song on 07/11/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit
@testable import RowingPostureApp

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

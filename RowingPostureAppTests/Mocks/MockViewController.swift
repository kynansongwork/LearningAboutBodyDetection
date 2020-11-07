//
//  MockViewController.swift
//  RowingPostureAppTests
//
//  Created by Kynan Song on 07/11/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit
@testable import RowingPostureApp

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

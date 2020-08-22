//
//  AppCoordinator.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 18/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit

enum AppTransitions: TransitionRef {
    case MainOptions
}

class AppCoordinator: BaseCoordinator {

    weak var parentCoordinator: BaseCoordinator?
    var childCoordinator: BaseCoordinator?
    var rootViewController: UIViewController
    var navController: UINavigationController
    
    var overlayWindow: UIWindow
    
    //var mainOptionsCoordinator: MainOptionsCoordinator?
    
    required init() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.isHidden = true
        self.rootViewController = navController
    }
    
    func reset() {
        //
    }
    
    @discardableResult func transition(to page: TransitionRef, object: Any?) -> Bool {
        guard let page = page as? AppTransitions else {
            return false
        }
        
        switch page {
        case .MainOptions:
            presentMainOptions()
        }
        return true
    }
    
    func dismiss(_ completion: (() -> Void)?) {
        //
    }
    
    func dismiss() {
        //
    }
}

extension AppCoordinator {
    
    func presentMainOptions() {
        print("Main options page")
    }
}

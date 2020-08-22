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
    
    var overlayWindow: UIWindow?
    
    required init() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.isHidden = true
        self.rootViewController = navController
    }
    
    func prepare() {
        self.transition(to: AppTransitions.MainOptions)
    }
    
    @discardableResult func transition(to page: TransitionRef, object: Any? = nil) -> Bool {
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
        dismissInternal(completion)
    }
    
    func dismiss() {
        dismissInternal()
    }
}

extension AppCoordinator {
    
    func presentMainOptions() {
        print("Main options page")
        let mainOptionsCoordinator = MainOptionsCoordinator()
        try? present(mainOptionsCoordinator, animated: false)
    }
}

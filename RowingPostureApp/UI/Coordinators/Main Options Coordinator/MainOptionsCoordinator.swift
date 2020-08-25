//
//  MainOptionsCoordinator.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 22/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit

enum MainOptionsTransitions: TransitionRef {
    case CaptureView
    case AnalysisView
    case SettingsView
}

class MainOptionsCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: BaseCoordinator?
    var childCoordinator: BaseCoordinator?
    var rootViewController: UIViewController
    
    let mainOptionsController: MainOptionsViewController
    
    required init() {
        mainOptionsController = MainOptionsViewController.instatiateFromStoryboard(storyboard: .Main, with: BaseViewModel())
        self.rootViewController = CustomNavController(rootViewController: mainOptionsController)
        prepare()
    }
    
    func prepare() {
        mainOptionsController.viewModel.coordinator = self
    }
    
    @discardableResult func transition(to page: TransitionRef, object: Any?) -> Bool {
        if let page = page as? MainOptionsTransitions {
            switch page {
            case .AnalysisView:
                break
            case .CaptureView:
                break
            case .SettingsView:
                break
            }
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

extension MainOptionsCoordinator {
    // TODO: Functions to transition to the other views.
}

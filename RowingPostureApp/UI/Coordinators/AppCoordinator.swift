//
//  AppCoordinator.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 18/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit

enum AppTransitions: TransitionRef {
    case CaptureView
    case AnalysisView
    case SettingsView
}

class AppCoordinator: BaseCoordinator {

    weak var parentCoordinator: BaseCoordinator?
    var childCoordinator: BaseCoordinator?
    var rootViewController: UIViewController
    
    let mainOptionsViewController: MainOptionsViewController
    
    required init() {
        mainOptionsViewController = MainOptionsViewController.instatiateFromStoryboard(storyboard: .Main, with: MainOptionsViewModel())
        mainOptionsViewController.view.backgroundColor = .white
        self.rootViewController = CustomNavController(rootViewController: mainOptionsViewController)
        prepare()
    }
    
    func prepare() {
        mainOptionsViewController.viewModel.coordinator = self
    }
    
     @discardableResult func transition(to page: TransitionRef, object: Any?) -> Bool {
           if let page = page as? AppTransitions {
               switch page {
               case .AnalysisView:
                   break
               case .CaptureView:
                   showCapturePage()
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

extension AppCoordinator {
    
    func showCapturePage() {
        let controller = VideoCaptureViewController.instatiateFromStoryboard(storyboard: .Main, with: VideoCaptureViewModel(coordinator: self))
        self.show(viewController: controller)
    }
}

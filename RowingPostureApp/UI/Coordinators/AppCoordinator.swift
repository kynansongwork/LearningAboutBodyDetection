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
        let navController = CustomNavController(rootViewController: mainOptionsViewController)
        navController.navigationBar.isHidden = true
        self.rootViewController = navController
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
                   presetCapturePage()
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
    
    func presetCapturePage() {
        let controller = VideoCaptureViewController.instatiateFromStoryboard(storyboard: .Main, with: VideoCaptureViewModel(coordinator: self))
        let navController = CustomNavController(rootViewController: controller)
        navController.navigationBar.isHidden = true
        self.rootViewController.present(navController, animated: true, completion: nil)
    }
}

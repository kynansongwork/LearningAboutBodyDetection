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
                   presetSettingsPage()
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
    
    func presetCapturePage() {
        let controller = VideoCaptureViewController.instatiateFromStoryboard(storyboard: .Main, with: VideoCaptureViewModel(coordinator: self))
        let navController = CustomNavController(rootViewController: controller)
        navController.navigationBar.isHidden = true
        self.rootViewController.present(navController, animated: true, completion: nil)
    }
    
    func presetSettingsPage() {
        let controller = SettingsViewController.instatiateFromStoryboard(storyboard: .Main, with: SettingsViewModel(coordinator: self))
        let navController = CustomNavController(rootViewController: controller)
        self.rootViewController.present(navController, animated: true, completion: nil)
    }
}

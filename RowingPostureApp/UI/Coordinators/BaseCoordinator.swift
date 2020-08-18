//
//  BaseCoordinator.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 18/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit

enum CoordinatorError: Error {
    case childAlreadyExists
    case childTypeMismatch
}

enum StoryBoardRef: String {
    case main
    case MainView
    case RecordView
    case AnalysisView
    case SettingsView
}

protocol TransitionRef {}

struct CoordinatorStack {
    let coordinator: BaseCoordinator
    let viewControllers: [UIViewController]
}

protocol BaseCoordinator: class {
    var parentCoordinator: BaseCoordinator? { get set }
    var childCoordinator: BaseCoordinator? { get set }
    
    //The rootVC is the base of the coordinator, pushing views on will recquire a UINavController.
    var rootViewController: UIViewController { get }
    
    init()
    
    //Supresses 'Result unused' warning.
    @discardableResult func transition(to page: TransitionRef, object: Any?) -> Bool
    func dismiss(_ completion: (() -> Void)?)
    func dismiss()
    func reset()
    func getStack() -> (CoordinatorStack)
}

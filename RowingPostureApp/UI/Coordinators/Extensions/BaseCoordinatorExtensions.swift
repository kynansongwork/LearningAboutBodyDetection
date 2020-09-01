//
//  BaseCoordinatorExtensions.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 18/08/2020.
//

import UIKit

extension BaseCoordinator {
    
    func present(_ child: BaseCoordinator, animated: Bool = true, completion: (() -> Void)? = nil) throws {
        guard childCoordinator == nil else {
            print("Can't present child on coordinator that is already with child")
            throw CoordinatorError.childAlreadyExists
        }
        
        self.childCoordinator = child
        child.parentCoordinator = self
        self.rootViewController.present(child.rootViewController, animated: animated) {
            completion?()
        }
    }
    
    func show(viewController: UIViewController, completion: (() -> Void)? = nil) {
        if let navController = rootViewController as? CustomNavController {
            navController.pushViewController(viewController: viewController, animated: true, completion: completion)
        } else {
            print("Attempting to push view contoller onto rootVC that is not of type UINavigationController")
        }
    }
    
    func dismissInternal(_ animated: Bool = false, completion: (() -> Void)? = nil) {
        try? parentCoordinator?.remove(self)
        parentCoordinator = nil
        rootViewController.dismiss(animated: animated) {
            try? self.parentCoordinator?.remove(self)
            self.parentCoordinator = nil
            completion?()
        }
    }
    
    func dismissInternal(_ completion: (() -> Void)? = nil) {
        dismissInternal(true, completion: completion)
    }
    
    func remove(_ child: BaseCoordinator) throws {
        guard child.rootViewController === childCoordinator?.rootViewController else {
            print("Attempting to remove child from coordinator with a non matching child type.")
            throw CoordinatorError.childTypeMismatch
        }
    }
    
    func reset() {
        reset(true)
    }
    
    func reset(_ animated: Bool = true) {
        if let navController = rootViewController as? UINavigationController {
            navController.popToRootViewController(animated: animated)
            (navController.viewControllers.first as? ViewModelDelegate)?.viewModelNeedsUpdate()
        } else {
            print("Attempting to pop view controllers when rootVC is not of type UINavigation controller.")
        }
    }
    
    func getStack() -> [CoordinatorStack] {
        var rootCoordinator: BaseCoordinator = self
        
        while rootCoordinator.parentCoordinator != nil, !(rootCoordinator.parentCoordinator is AppCoordinator) {
            rootCoordinator = rootCoordinator.parentCoordinator!
        }
        
        var stack: [CoordinatorStack] = []
        var coordinator: BaseCoordinator? = rootCoordinator
        
        //repeat is similar to a while loop, however conditon cehck occurs at the end, so the code in the loop will be run at least once.
        repeat {
            stack.append(CoordinatorStack(coordinator: coordinator!, viewControllers: coordinator!.getViewControllers()))
            coordinator = coordinator?.childCoordinator
        } while (coordinator != nil)
        return stack
    }
    
    private func getViewControllers() -> [UIViewController] {
        if let navCoordinator = rootViewController as? UINavigationController {
            print(navCoordinator.viewControllers)
            return navCoordinator.viewControllers
        } else {
            return [rootViewController]
        }
    }
}

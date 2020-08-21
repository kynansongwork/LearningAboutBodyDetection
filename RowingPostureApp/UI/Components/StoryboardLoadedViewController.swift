//
//  StoryboardLoadedViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 21/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit

protocol StoryboardLoadedViewController: ModeledViewController {
    
    static func instatiateFromStoryboard(storyboard: StoryBoardRef, with viewModel: ViewModel) -> Self
    //Loading a view requires a ref and viewModel, which can be generic.
}

extension StoryboardLoadedViewController {
    static func instatiateFromStoryboard(storyboard: StoryBoardRef, with viewModel: ViewModel) -> Self {
        let className = NSStringFromClass(self).components(separatedBy: ".")[1]
        // Reformat identifiers that are automatically generated.
        
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: className) as! Self
        viewController.viewModel = (viewModel as! Self.AnyViewModel)
        viewController.setAsDelegate(for: viewModel)
        return viewController
    }
}

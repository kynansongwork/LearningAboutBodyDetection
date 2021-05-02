//
//  AnalysisViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 02/05/2021.
//  Copyright © 2021 xDesign. All rights reserved.
//

import UIKit

class AnalysisViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: AnalysisViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar() 
    }
    
    func setUpNavBar() {
        let closeButton = UIButton()
        let closeImage = UIImage(named: "icClose")
        let whiteImage = closeImage?.withRenderingMode(.alwaysTemplate)
        closeButton.frame = CGRect(x: 0, y: 0, width: 51, height: 31)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        closeButton.setImage(whiteImage, for: .normal)
        closeButton.tintColor = .blue
        closeButton.addTarget(self, action: #selector(dismissAnalysisView), for: .touchUpInside)
        closeButton.accessibilityIdentifier = "icClose"
        closeButton.isAccessibilityElement = true
        
        let closeModalButton = UIBarButtonItem()
        closeModalButton.customView = closeButton
        closeModalButton.customView?.tintColor = .blue
        self.navigationItem.leftBarButtonItem = closeModalButton
    }
    
    @objc func dismissAnalysisView() {
        viewModel.coordinator?.dismiss()
    }
    
}

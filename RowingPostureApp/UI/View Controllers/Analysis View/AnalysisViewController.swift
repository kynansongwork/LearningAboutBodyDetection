//
//  AnalysisViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 02/05/2021.
//  Copyright © 2021 xDesign. All rights reserved.
//

import UIKit
import Combine

class AnalysisViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: AnalysisViewModel!
    private var contentView: AnalysisView!

    private var subscriptions = Set<AnyCancellable>()

    let closeButton: UIButton = {
        let temp = UIButton()
        let closeImage = UIImage(named: "icClose")
        let whiteImage = closeImage?.withRenderingMode(.alwaysTemplate)
        temp.frame = CGRect(x: 0, y: 0, width: 51, height: 31)
        temp.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        temp.setImage(whiteImage, for: .normal)
        temp.tintColor = .blue
        temp.accessibilityIdentifier = "icClose"
        temp.isAccessibilityElement = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView = AnalysisView()
        //view = contentView
        setUpNavBar()
        bindView()
    }
    
    func setUpNavBar() {
        let closeModalButton = UIBarButtonItem()
        closeModalButton.customView = closeButton
        closeModalButton.customView?.tintColor = .blue
        self.navigationItem.leftBarButtonItem = closeModalButton
    }

    func bindView() {
        closeButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.dismissSettings()
            }.store(in: &subscriptions)
    }

    func dismissSettings() {
        viewModel.coordinator?.dismiss()
    }
    
    @objc func dismissAnalysisView() {
        viewModel.coordinator?.dismiss()
    }
    
}

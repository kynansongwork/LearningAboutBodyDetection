//
//  ModeledViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 18/08/2020.
//

import UIKit

protocol ModeledViewController: ViewModelDelegate {
    associatedtype AnyViewModel = ViewModel
    
    var viewModel: AnyViewModel! { get set }
    
    func setAsDelegate(for viewModel: ViewModel)
}

extension ModeledViewController {
    
    func setAsDelegate(for viewModel: ViewModel) {
        viewModel.delegate = self
    }
}

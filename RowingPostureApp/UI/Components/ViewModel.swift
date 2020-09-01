//
//  ViewModel.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 18/08/2020.
//

import UIKit

protocol ViewModel: class {
    var coordinator: BaseCoordinator? { get set }
    var delegate: ViewModelDelegate? { get set }
}

enum ViewModelError: Error {
    case genericError
}

protocol ViewModelDelegate: class {
    func viewModelDidUpdate()
    func viewModelDidError(error: ViewModelError)
    func viewModelNeedsUpdate()
}

extension ViewModelDelegate {
    func viewModelDidUpdate() {}
    func viewModelNeedsUpdate() {}
    func viewModelDidError(error: ViewModelError) {
        print("View model did error with \(error), but VC does not conform to this method.")
    }
}

class BaseViewModel: NSObject, ViewModel {
    weak var coordinator: BaseCoordinator?
    weak var delegate: ViewModelDelegate?
    
    override init() {
        super.init()
    }
    
    init(coordinator: BaseCoordinator) {
        self.coordinator = coordinator
        super.init()
    }
}

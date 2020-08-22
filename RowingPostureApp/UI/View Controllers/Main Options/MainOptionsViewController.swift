//
//  MainOptionsViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 22/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit

class MainOptionsViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: ViewModel!
    
    
    @IBOutlet weak var analyseButton: RoundButton!
    @IBOutlet weak var recordButton: RoundButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

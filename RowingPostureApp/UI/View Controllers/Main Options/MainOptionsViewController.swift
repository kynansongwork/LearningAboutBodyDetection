//
//  MainOptionsViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 22/08/2020.
//

import UIKit

class MainOptionsViewController: UIViewController, StoryboardLoadedViewController {
    
    var viewModel: MainOptionsViewModel!
    
    @IBOutlet weak var analyseButton: RoundButton!
    @IBOutlet weak var recordButton: RoundButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.landscapeRight)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Resets lock - may not neet this based on the plans for the app.
        AppUtility.lockOrientation(.all)
    }

    @IBAction func recordButtonTapped(_ sender: Any) {
        viewModel.coordinator?.transition(to: AppTransitions.CaptureView, object: nil)
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        viewModel.coordinator?.transition(to: AppTransitions.SettingsView, object: nil)
    }
}

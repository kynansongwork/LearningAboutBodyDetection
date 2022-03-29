//
//  MainOptionsViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 22/08/2020.
//

import UIKit
import Combine

class MainOptionsViewController: UIViewController, StoryboardLoadedViewController {
    
    var viewModel: MainOptionsViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var analyseButton: RoundButton!
    @IBOutlet weak var recordButton: RoundButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        AppUtility.lockOrientation(.landscapeRight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Resets lock - may not neet this based on the plans for the app.
        AppUtility.lockOrientation(.all)
    }

    func bindView() {
        analyseButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.coordinator?.transition(to: AppTransitions.AnalysisView, object: nil)
            }.store(in: &subscriptions)

        recordButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.coordinator?.transition(to: AppTransitions.CaptureView, object: nil)
            }.store(in: &subscriptions)

        settingsButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.viewModel.coordinator?.transition(to: AppTransitions.SettingsView, object: nil)
            }.store(in: &subscriptions)
    }
}

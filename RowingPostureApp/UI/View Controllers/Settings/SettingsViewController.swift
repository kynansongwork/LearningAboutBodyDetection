//
//  SettingsViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//

import UIKit
import CoreBluetooth

class SettingsViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: SettingsViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "settingsCell")
        
        setUpNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadSettings()
    }
    
    func setUpNavBar() {
        let closeButton = UIButton()
        let closeImage = UIImage(named: "icClose")
        let whiteImage = closeImage?.withRenderingMode(.alwaysTemplate)
        closeButton.frame = CGRect(x: 0, y: 0, width: 51, height: 31)
        closeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        closeButton.setImage(whiteImage, for: .normal)
        closeButton.tintColor = .blue
        closeButton.addTarget(self, action: #selector(dismissSettings), for: .touchUpInside)
        closeButton.accessibilityIdentifier = "icClose"
        closeButton.isAccessibilityElement = true
        
        let closeModalButton = UIBarButtonItem()
        closeModalButton.customView = closeButton
        closeModalButton.customView?.tintColor = .blue
        self.navigationItem.leftBarButtonItem = closeModalButton
    }
    
    @objc func dismissSettings() {
        viewModel.coordinator?.dismiss()
        viewModel.saveSettings()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cells = viewModel?.cells {
            return cells.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let baseCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let settingCell = tableView.dequeueReusableCell(withIdentifier:
            "settingsCell", for: indexPath) as! SettingsCell
        
        settingCell.confidenceValueSlider.tag = indexPath.row
        settingCell.confidenceValueSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        if indexPath.row != 5 {
            settingCell.settingLabel.text = viewModel.cells[indexPath.row]
            
            if indexPath.row == 0 {
                settingCell.confidenceValueSlider.value = Float(viewModel.configuration.jointConfidenceThreshold)
            } else if indexPath.row == 1 {
                settingCell.confidenceValueSlider.value = Float(viewModel.configuration.poseConfidenceThreshold)
            } else if indexPath.row == 2 {
                settingCell.confidenceValueSlider.value = Float(viewModel.configuration.localSearchRadius)
            } else if indexPath.row == 3 {
                settingCell.confidenceValueSlider.value = Float(viewModel.configuration.matchingJointDistance)
            } else if indexPath.row == 4 {
                settingCell.confidenceValueSlider.value = Float(viewModel.configuration.adjacentJointOffsetRefinementSteps)
            }
            
            return settingCell
        } else {
            baseCell.textLabel?.text = viewModel.cells[5]
            return baseCell
        }
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        let row = sender.tag
        //print("\(viewModel.cells[row]) has a confidence level of \(currentValue).")
        viewModel.configureConfidenceLevels(sliderRow: row, sliderValue: currentValue)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.cells[indexPath.row])
        
        if viewModel.cells[indexPath.row] == SettingsHeaders().blueTooth {
            viewModel.scanForDevices()
        }
    }
    
    
}

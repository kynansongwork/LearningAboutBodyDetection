//
//  SettingsViewController.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 31/08/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: SettingsViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
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
        closeButton.addTarget(self, action: #selector(dismissSettings), for: .touchUpInside)
        closeButton.accessibilityIdentifier = "icClose"
        closeButton.isAccessibilityElement = true
        
        let closeModalButton = UIBarButtonItem()
        closeModalButton.customView = closeButton
        closeModalButton.customView?.tintColor = .white
        self.navigationItem.rightBarButtonItem = closeModalButton
    }
    
    @objc func dismissSettings() {
        viewModel.coordinator?.dismiss()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        if let settingsCell = cell as? UITableViewCell {
            settingsCell.textLabel?.text = viewModel.cells[indexPath.row]
            
            return cell
        }
    }
    
    
}

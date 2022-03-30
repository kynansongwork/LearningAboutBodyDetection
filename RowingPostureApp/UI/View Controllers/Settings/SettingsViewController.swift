// Copyright © 2022 xDesign. All rights reserved.

import Combine
import CoreBluetooth
import UIKit

class SettingsViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: SettingsViewModel!
    private var contentView: SettingsView!

    private var subscriptions = Set<AnyCancellable>()

    let closeButton = CloseButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView = SettingsView()
        view = contentView
        setUpNavBar()
        setUpView()
        bindView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadSettings()
    }

    func setUpView() {
        contentView.sliderTableView.delegate = self
        contentView.sliderTableView.dataSource = self
    }

    func setUpNavBar() {
        let closeModalButton = UIBarButtonItem()
        closeModalButton.customView = closeButton
        closeModalButton.customView?.tintColor = .blue
        navigationItem.leftBarButtonItem = closeModalButton
    }

    func bindView() {
        closeButton.publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.dismissSettings()
            }.store(in: &subscriptions)
    }

    func dismissSettings() {
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
                settingCell.confidenceValueSlider
                    .value = Float(viewModel.configuration.adjacentJointOffsetRefinementSteps)
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
        // print("\(viewModel.cells[row]) has a confidence level of \(currentValue).")
        viewModel.configureConfidenceLevels(sliderRow: row, sliderValue: currentValue)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.cells[indexPath.row])

        if viewModel.cells[indexPath.row] == SettingsHeaders().blueTooth {
            viewModel.scanForDevices()
        }
    }
}

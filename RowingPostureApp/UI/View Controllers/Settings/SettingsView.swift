// Copyright © 2022 xDesign. All rights reserved.

import Foundation
import UIKit
import TinyConstraints

class SettingsView: UIView {
    let sliderTableView: UITableView = {
        let temp = UITableView()
        return temp
    }()

    init() {
        super.init(frame: .zero)
        setUpTableView()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpTableView() {
        sliderTableView.estimatedRowHeight = 50
        sliderTableView.rowHeight = UITableView.automaticDimension

        sliderTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        sliderTableView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "settingsCell")
    }

    func layout() {
        addSubview(sliderTableView)
        sliderTableView.edgesToSuperview()
    }
}

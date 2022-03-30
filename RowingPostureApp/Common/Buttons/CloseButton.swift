//
//  CloseButton.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 30/03/2022.
//  Copyright © 2022 xDesign. All rights reserved.
//

import UIKit

class CloseButton: UIButton {

    init() {
        super.init(frame: .zero)
        privateInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func privateInit() {
        let closeImage = UIImage(named: "icClose")
        let whiteImage = closeImage?.withRenderingMode(.alwaysTemplate)
        self.frame = CGRect(x: 0, y: 0, width: 51, height: 31)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        self.setImage(whiteImage, for: .normal)
        self.tintColor = .blue
        self.accessibilityIdentifier = "icClose"
        self.isAccessibilityElement = true
    }
}

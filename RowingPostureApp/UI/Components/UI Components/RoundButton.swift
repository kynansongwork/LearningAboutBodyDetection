//
//  RoundButton.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 22/08/2020.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColour: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColour.cgColor
        }
    }
}

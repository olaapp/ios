//
//  SwitchExtension.swift
//  AESApp
//
//  Created by Alex on 6/20/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit


extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}

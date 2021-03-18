//
//  TabBarExtensions.swift
//  AESApp
//
//  Created by Alex on 5/3/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit


class CustomTabBar : UITabBar {
    @IBInspectable var height: CGFloat = 0.0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}

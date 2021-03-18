//
//  SliderExtension.swift
//  AESApp
//
//  Created by Willy gonzalez on 8/2/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit

import UIKit
class CustomSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 2
        return rect
    }
}

//
//  RoundedImageView.swift
//  AESApp
//
//  Created by Alex on 6/18/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = self.frame.width/2.0
        layer.cornerRadius = radius
    }

}



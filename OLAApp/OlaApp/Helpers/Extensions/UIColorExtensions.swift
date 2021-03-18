//
//  UIColorExtensions.swift
//  AESApp
//
//  Created by Alex on 5/13/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

private static let kLayerNameGradientBorder = "GradientBorderLayer"

    func setGradientBorder(
) {
    let existedBorder = gradientBorderLayer()
    let border = existedBorder ?? CAGradientLayer()
    border.frame = bounds
        border.startPoint = CGPoint(x: 0.0, y: 0.5)
        border.endPoint = CGPoint(x: 1.0, y: 0.5)
    border.colors =
    [UIColor(red: 0.5, green: 0.74, blue: 0.25, alpha: 0.55).cgColor,
     UIColor(red: 0.0, green: 0.46, blue: 0.69, alpha: 0.19).cgColor]
    let mask = CAShapeLayer()
    mask.path = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
    mask.fillColor = UIColor.clear.cgColor
    mask.strokeColor = UIColor.black.cgColor
    mask.lineWidth = 10
    
    border.mask = mask
    
    let exists = existedBorder != nil
    if !exists {
        layer.addSublayer(border)
    }
}

    func removeGradientBorder() {
    self.gradientBorderLayer()?.removeFromSuperlayer()
}

private func gradientBorderLayer() -> CAGradientLayer? {
    let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
    if borderLayers?.count ?? 0 > 1 {
        fatalError()
    }
    return borderLayers?.first as? CAGradientLayer
}
}

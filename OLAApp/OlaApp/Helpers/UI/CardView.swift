//
//  CardView.swift
//  AESApp
//
//  Created by Alex on 6/9/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerradius:CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth:CGFloat = 0
    @IBInspectable var shadowOffsetHeight:CGFloat = 3
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray
    @IBInspectable var shadowOpacity: CGFloat = 0.3
    
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func layoutSubviews() {
        
        // Corner..............
        layer.cornerRadius = cornerradius
        
        // Shadow...........
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
        layer.masksToBounds = false
        
        // Border.............
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}

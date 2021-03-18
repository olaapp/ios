//
//  ProfileTableCell.swift
//  AESApp
//
//  Created by Alex on 5/29/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit

class ProfileTableCell: UITableViewCell {
    var setServices: NICSResponseData?{
        didSet {
            setupCell()
            
        }
    }
    
    
    // MARK: - Let-Var
    
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    func setupCell(){
        guard let services = setServices else{return}
        
        titleLabel.text =  services.nic.description
        
        addressLabel.text = services.nicAddress
        
    }
    
    
}

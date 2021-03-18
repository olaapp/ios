//
//  NotificationTableCell.swift
//  AESApp
//
//  Created by Alex on 6/7/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit

class NotificationTableCell: UITableViewCell {

    var setNotification: NotificationsHistoryResponseData?{
        didSet {
            setupCell()
        }
    }
    
    
    // MARK: - Let-Var
    let locale = Locale.init(identifier: "en_US_POSIX")
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
    func setupCell(){
        guard let notifications = setNotification else{return}
        
        
        
        titleLabel.text = notifications.notificationTitle
        detailsLabel.text = notifications.notificationBody
        
        if let date = notifications.createdDt{
            
            
            if let datew = Date(fromString: date, format: .httpHeader, locale: locale)
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                formatter.timeZone = .gmt
                let dateISO = datew.toISO()
                print("\(formatter.string(from: datew))")
                
                dateLabel.text = "\(formatter.string(from: datew))"
                
                
            }else{
                dateLabel.text = "No disponible"
            }
            
        }else{
            dateLabel.text = "No disponible"
        }
        
        
    }
    
}

//
//  NotificationsListController+TableViewDelegate.swift
//  AESApp
//
//  Created by Alex on 6/10/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit


extension NotificationsListController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count > 0 ? data.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = notificationsTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.notificationTableCell, for: indexPath) as? NotificationTableCell else { return UITableViewCell() }
        
        if !data.isEmpty{
            cell.setNotification = data[indexPath.row]
            cell.dateTitleLabel.text = "Fecha"
        }else{
            cell.dateTitleLabel.text = "Sin notificaciones"
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        if !data.isEmpty{
//            
//            weak.dataInstanced = data[indexPath.row]
//            
//            Core.shared.performSegue(controller: weak, identifier: K.segues.news.listNewsControllerToNewsDetailController)
        }
        
        
    }
    
    
    
    
    
}

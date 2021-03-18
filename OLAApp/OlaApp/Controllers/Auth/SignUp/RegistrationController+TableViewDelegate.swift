//
//  RegistrationController+TableViewDelegate.swift
//  AESApp
//
//  Created by Alex on 5/29/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit


extension RegistrationController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerNICItems.count > 0 ? registerNICItems.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = servicesTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.registerServicesTableCell, for: indexPath) as? RegisterServicesTableCell else { return UITableViewCell() }
        
        if !registerNICItems.isEmpty{
            cell.setServices = registerNICItems[indexPath.row]
        }
        
        return cell
    }
    
    
    
}



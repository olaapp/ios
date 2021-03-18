//
//  ProfileController+TableViewDelegate.swift
//  AESApp
//
//  Created by Alex on 6/20/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit


extension ProfileController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nics.count > 0 ? nics.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = nicTableView.dequeueReusableCell(withIdentifier: K.cellsIdentifiers.table.profileTableCell, for: indexPath) as? ProfileTableCell else { return UITableViewCell() }
        
        if !nics.isEmpty{
            cell.setServices = nics[indexPath.row]
        }
        
        return cell
    }
    
}

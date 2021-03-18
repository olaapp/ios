//
//  NotificationsListController.swift
//  AESApp
//
//  Created by Alex on 6/6/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import Alamofire

class NotificationsListController: UIViewController {
    
    // MARK: - Let-Var
    var selectedNewsInformationModel: NewsInformationModel?
    var data = [NotificationsHistoryResponseData]()
    var dataInstanced:NotificationsHistoryResponseData?
    
    open var header: HTTPHeaders{
     let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.token)
        let bearer = Core.shared.setBearerToken(token)
        return
         [
             "Authorization": bearer,
             "Content-Type": "application/json"
         ]
    }
    
    // MARK: - Outlets
    @IBOutlet weak var notificationsTableView: UITableView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
               setUpActions()
               
        // setting up UI elements to be used through the code
               setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Load news
        getNotifications()
        
        //Set a new event
        Core.shared.event(code: K.eventsCode.news, name: K.eventsName.newsScreen)
        
    }
    
    
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == K.segues.news.listNewsControllerToNewsDetailController {
//            let detailController = segue.destination as! NewsDetailController
//            detailController.dataInstanced = dataInstanced
//        }
        
//
//    }
    

    func setUpUI(){}

    func setUpActions(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        //Tableview Delegate
        notificationsTableView.delegate = weak
        notificationsTableView.dataSource = weak
        
        //Set Cell Identifier
        Core.shared.registerCell(at: notificationsTableView, named: K.cellsIdentifiers.table.notificationTableCell)
        
    }
    
    
    //Dimiss action
    @IBAction func dimissAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //API
    //-- Get News
    private func getNotifications(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        if !weak.data.isEmpty{
            weak.data.removeAll()
        }
        
        
        NotificationsManager().notifications(header: header) {
            response in
            guard let notifications  = response, ((response?.data) != nil) else{
                
                return
                
            }
            
            switch notifications.message{
            case ResponseMessages.success.message:
                if !notifications.data.isEmpty{
                    
                    weak.data = notifications.data
                    weak.notificationsTableView.reloadData()
                    
                }
                break
                
            default:
                return
            }
            
            
        }
    }
    
    
    // MARK: - Objective C
    
}

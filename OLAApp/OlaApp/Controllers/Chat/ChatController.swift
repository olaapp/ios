//
//  ChatController.swift
//  AESApp
//
//  Created by Alex on 6/6/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import WebKit

class ChatController: UIViewController {
    
    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var chatWebView: WKWebView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
               setUpActions()
               
        // setting up UI elements to be used through the code
               setUpUI()
        
    }
    

    
    func setUpUI(){}

    func setUpActions(){
        
        let url = URL(string: K.chatURL)
        var urlRequest = URLRequest(url: url!)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        chatWebView.load(urlRequest)
    }
    
    

}

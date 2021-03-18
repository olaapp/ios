//
//  SignInController+ GIDSignInDelegate.swift
//  AESApp
//
//  Created by Alex on 5/2/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth


extension SignInController: GIDSignInDelegate {
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        
        //Retrive data
        guard let userName = user.profile.name,
            let email = user.profile.email,
            let userID = user.userID
            else {return}
        
        let givenName = user.profile.givenName ?? ""
        let familyName = user.profile.familyName ?? ""
        
        
        let photo = user.profile.imageURL(withDimension: 400).absoluteString
        var items = userName.components(separatedBy: " ")
        //take one array for splitting the string
        let firstName = items[0]
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        
        
        Auth.auth().signIn(with: credential, completion: { (user, error)  in
            guard let errorInstanced = error else{
                if weak.isPresented || weak.fromManagaments{

                    weak.registerUser(
                    email: email,
                    password: email,
                    name: givenName,
                    last_name: familyName,
                    birthday: "",
                    provider: "Google",
                    firebase_uuid: user?.user.uid ?? "0",
                    push_tok: Singleton.shared.checkPushToken(),
                    phone_number: "",
                    phone_language: "",
                    type: .google)

                }
                
                
                return
            }
            
            
            print(errorInstanced)
            
        })
        
    }
    
}

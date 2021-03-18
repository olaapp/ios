//
//  NumberCodeController.swift
//  AESApp
//
//  Created by Alex on 5/6/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import MaterialComponents
import GoogleSignIn
import FirebaseAuth
import Alamofire


class NumberCodeController: UIViewController {
    
    
    // MARK: - Let-Var
    var codeNumber = String()
    var phoneNumber = String()
    var phoneNumberNoArea = String()
    open var header: HTTPHeaders{
            return ["Content-Type": "application/json"]
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var codeTextField: MDCOutlinedTextField!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    
    //--Constraint
    
    @IBOutlet weak var topLogo: NSLayoutConstraint!
    @IBOutlet weak var topWelcomeLabel: NSLayoutConstraint!
    @IBOutlet weak var topTextFields: NSLayoutConstraint!
    @IBOutlet weak var topSignInButton: NSLayoutConstraint!
    
    
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
        print(codeNumber)
        
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){
        
        //--Set attributed title on recoveryPasswordButton
        Core.shared.attributedtextButton(button: retryButton, string1: K.titles.retryButton.text1, string2: K.titles.retryButton.text2)
    }
    
    func setUpActions(){
        
        //Setting textfield outlined
        //--Code Number textfield
        Core.shared.attributesMDCOutlinedTextField(textfield: codeTextField,labelText: TextFieldText.code.label, placeholder: K.placeholder.typeCodeNumber)
        
        //Creating provider to use with credentials
        
        
        
    }
    
    private func gettingData(){}
    
    
    
    //To check code
    @IBAction func checkCodeAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        guard let verificationCode = codeTextField.text else{
            return
        }
        
        //To set credential
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: codeNumber,
            verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            guard let errorInstanced = error else{
                weak.registerByPhone(
                    firebase_uuid: authResult?.user.uid ?? "0",
                    push_tok:Singleton.shared.checkPushToken(),
                    phone_number: weak.phoneNumberNoArea,
                    phone_language: "")
                return
            }
            
            
            Core.shared.performSegue(controller: weak, identifier: K.segues.auth.siginInToMainController)
        }
        
        
    }
    
    
    
    //Retry sending code
    @IBAction func retryAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error)
                return
            }
            
            
            weak.codeNumber = verificationID!
            
        }
    }
    
    
    
    
    
    //API
    //--SigIn Users
    func signInPhone(_ email: String, _ password: String){
        
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let params: Parameters =
            ["email":email,
             "password": password]
        
        UserManager().signInUser(header: header, params: params) {
            response in
            
            guard let auth = response else{ return}
            
            switch auth.message{
                
            case AuthMessages.done.message:
                Singleton.shared.saveSignInState(isSet: true)
                weak.dismiss(animated: true, completion: nil)
                break
            case AuthMessages.notRegistered.message:
                print("Sin registro")
                break
            default:
                return
            }
        }
    }
    
    //--Register By Phone
    func registerByPhone(firebase_uuid: String,
                      push_tok: String,
                      phone_number: String,
                      phone_language: String){
        
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        let params: Parameters =
            ["firebase_uuid": firebase_uuid,
             "push_tok": push_tok,
             "phone_number": phone_number,
             "phone_language": phone_language ]
        
        
        UserManager().registerUserByPhone(header: header, params: params) {
            response in
            
            guard let auth = response else{ return}
            
            switch auth.message{
                
            case AuthMessages.doneRegisted.message:
                Singleton.shared.saveSignInState(isSet: true)
                Singleton.shared.setOauthToken(accessToken: auth.authToken)
                weak.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                break
            case AuthMessages.done.message:
                Singleton.shared.saveSignInState(isSet: true)
                weak.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                break
            case AuthMessages.notRegistered.message:
                print(auth.message)
                break
            default:
                return
            }
        }
    }
    
    
    
}

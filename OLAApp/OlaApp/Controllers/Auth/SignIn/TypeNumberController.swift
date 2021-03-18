//
//  TypeNumberController.swift
//  AESApp
//
//  Created by Alex on 5/6/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import MaterialComponents
import GoogleSignIn
import FirebaseAuth
import NVActivityIndicatorView


class TypeNumberController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Let-Var
    var codeNumber = ""
    var phoneNumber = ""
    var phoneNumberNoArea = ""
    
    
    // MARK: - Outlets
    @IBOutlet weak var phoneNumberTextField: MDCOutlinedTextField!
    
    @IBOutlet weak var checkButton: UIButton!
    
    //--Constraint
    
    @IBOutlet weak var topLogo: NSLayoutConstraint!
    @IBOutlet weak var topWelcomeLabel: NSLayoutConstraint!
    @IBOutlet weak var topTextFields: NSLayoutConstraint!
    @IBOutlet weak var topCheckButton: NSLayoutConstraint!
    
    
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.auth.typeNumberToNumberCodeController {
            let numberCodeController = segue.destination as! NumberCodeController
            numberCodeController.codeNumber = codeNumber
            numberCodeController.phoneNumber = phoneNumber
            numberCodeController.phoneNumberNoArea = phoneNumberNoArea
        }
        
    }
    
    //Set fullscreen
    override open var prefersStatusBarHidden: Bool {return true}
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){
        
        //Modify constraints
        
    }
    
    func setUpActions(){
        
        //Setting textfield outlined
        //--Phone Number textfield
        Core.shared.attributesMDCOutlinedTextField(textfield: phoneNumberTextField,labelText: TextFieldText.phoneNumber.label, placeholder: K.placeholder.typePhoneNumber)
    }
    
    private func gettingData(){}
    
    //To check phone number
    @IBAction func checkPhoneAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        customLoading()
        
        guard let phoneNumberInstance = phoneNumberTextField.text else{
            return
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+503 "+phoneNumberInstance, uiDelegate: nil) { (verificationID, error) in
            
            weak.stopAnimating()
            if let error = error {
                print(error)
                return
            }
            
            
            weak.codeNumber = verificationID!
            weak.phoneNumber = "+503 "+phoneNumberInstance
            weak.phoneNumberNoArea = phoneNumberInstance
            
            Core.shared.performSegue(controller: weak, identifier: K.segues.auth.typeNumberToNumberCodeController)
            
        }
        
        
    }
    
    //Dimiss controller
    @IBAction func dimissControllerAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Custom loading
    func customLoading(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let size = CGSize(width: 32, height: 32)
        weak.startAnimating(size, message: "", type: NVActivityIndicatorType.circleStrokeSpin)
    }
    
    
}

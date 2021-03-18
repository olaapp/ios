//
//  RegistrationController.swift
//  AESApp
//
//  Created by Alex on 5/27/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import ETBinding
import Alamofire
import NVActivityIndicatorView

class RegistrationController: UIViewController, NVActivityIndicatorViewable{
    
    // MARK: - Let-Var
    var registerNICItems = RegisterNICItems()
    let liveData = LiveData(data: "RegisterNIC")
    var secondStep = false
    
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
    @IBOutlet weak var stepIndicatorView: StepIndicatorView!
    @IBOutlet weak var firstStepLabel: UILabel!
    @IBOutlet weak var secondStepLabel: UILabel!
    @IBOutlet weak var thirdStepLabel: UILabel!
    @IBOutlet weak var sheetView: UIView!
    @IBOutlet weak var nicTextField: MDCFilledTextField!
    @IBOutlet weak var numberLastBillTextField: MDCFilledTextField!
    @IBOutlet weak var servicesTableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
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
        
    }
    
    
    // MARK: - Navigation
    
    // MARK: - SetUps / Funcs
    func setUpUI(){
        
    }

    func setUpActions(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        //Tableview Delegate
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCell(at: servicesTableView, named: K.cellsIdentifiers.table.registerServicesTableCell)
        
        
        //Setting Nic outlined
        //--Email textfield
        Core.shared.attributesMDCFilledTextField(textfield: nicTextField,labelText: TextFieldText.NIC.label, placeholder: nil)
        nicTextField.keyboardType = .numberPad
        
        
        //--Last bill textfield
        Core.shared.attributesMDCFilledTextField(textfield: numberLastBillTextField,labelText: TextFieldText.lastBill.label, placeholder: K.messages.textLastBill)
        numberLastBillTextField.keyboardType = .numberPad
        
        //Current step
        stepIndicatorView.currentStep = 0
        Core.shared.setCurrentStep(label: weak.firstStepLabel)
        
        
        //Live data
        RegisterNICModelData.shared.liveData.observeForever { (data) in
            
            weak var weakSelf = self
            guard let weak = weakSelf else{return}
            
            print("\(String(describing: data.NIC + data.lastBillNumber))")
            
            weak.reloadData(data: data)
        }
        liveData.dispatch()
        
    }

    private func gettingData(){}
    
    
    //Registering data and reloading tableview
    func reloadData(data:RegisterNIC){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        weak.registerNICItems.append(data)
        weak.stepIndicatorView.currentStep = 1
        Core.shared.setCurrentStep(label: weak.secondStepLabel)
        
        weak.servicesTableView.reloadData()
    }
    
    
    //Adding a NIC
    @IBAction func addAction(_ sender: Any) {
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        guard let nic = nicTextField.text, !nicTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else{
            Core.shared.showCustomPopUp(controller: weak, title: K.titles.alertWrongTitle, issue: true, message: K.messages.emptyEmail)
            return
        }
        
        guard let billNumber = numberLastBillTextField.text, !numberLastBillTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else{
            Core.shared.showCustomPopUp(controller: weak, title: K.titles.alertWrongTitle, issue: true, message: K.messages.emptyPassword)
            return
        }
        
        
        if let nicInt = Int.init(nic),
           let billNumberInt = Int.init(billNumber){
            
            RegisterNICModelData.shared.NIC = nicInt
            RegisterNICModelData.shared.lastBillNumber = billNumberInt
            
            Core.shared.showCustomNamePopUp(controller: weak)
            

        }
        
    }
    
    
    //Next step Action
    @IBAction func nextStepAction(_ sender: UIButton) {
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        Core.shared.buttonAnimation(sender: sender)
        
        if !secondStep{
            //Second Step
            weak.stepIndicatorView.currentStep = 2
            Core.shared.setCurrentStep(label: weak.thirdStepLabel)
            
            //Set color at button
            weak.continueButton.setBackgroundImage(nil, for: .normal)
            weak.continueButton.backgroundColor = #colorLiteral(red: 0.5669036508, green: 0.7711592913, blue: 0.3214968145, alpha: 1)
            weak.continueButton.setTitle("FInalizar", for: .normal)
            weak.secondStep = true
            
            
        }else{
            //Third Step
            weak.stepIndicatorView.currentStep = 3
            Singleton.shared.saveSignInState(isSet: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
               
               
                weak.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

            }
        }
        
    }
    
    
    
    //API
    //--Set report
    func setReport(
        nic: String,
        alias: String,
        validationDocument: String){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        weak.customLoading()
        
        let params: Parameters =
        ["nic":nic,
         "alias": alias,
         "validation_document": validationDocument
        
        ]
        
        
        UserManager().setNic(header: header, params: params) {
            response in
            
            
            guard let message = response?.message else{return}
            
            if ResponseMessages.doneRegistered.message == message{
                
                if let id = response?.id{
                    
                    
                }
                
            }else{
                weak.stopAnimating()
            }
            
            
        }
    }
    

    
    
    //Custom loading
    func customLoading(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let size = CGSize(width: 30, height: 30)
        
        weak.startAnimating(size, message: "", type: .ballRotateChase)
    }
    
}

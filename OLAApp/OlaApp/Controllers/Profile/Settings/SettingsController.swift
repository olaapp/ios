//
//  SettingsController.swift
//  AESApp
//
//  Created by Alex on 6/20/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents
import Alamofire
import NVActivityIndicatorView
import FirebaseAuth

class SettingsController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - Let-Var
    var ifError = false
    var current = 0
    open var headerUser: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.token)
        let bearer = Core.shared.setBearerToken(token)
        return
            [
                "Authorization": bearer,
                "Content-Type": "application/json"
        ]
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var notificationOutagesSwitch: UISwitch!
    @IBOutlet weak var scheduledOutagesSwitch: UISwitch!
    @IBOutlet weak var billOutagesSwitch: UISwitch!
    @IBOutlet weak var billExpiredOutagesSwitch: UISwitch!
    @IBOutlet weak var cancelableServiceOutagesSwitch: UISwitch!
    @IBOutlet weak var serviceRestablishmentOutagesSwitch: UISwitch!
    @IBOutlet weak var pendientAccountOutagesSwitch: UISwitch!
    @IBOutlet var changePasswordButton: UIButton!
    
    
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
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        weak.userSettings()
        
        let email = Singleton.shared.checkValueSet(key: K.defaultKeys.others.email)
        if  email != ""{
            weak.changePasswordButton.isHidden = false
            
        }
        
    }
    
    // MARK: - Navigation
    
    
    
    // MARK: - SetUps / Funcs
    func setUpUI(){
        //Modifying switch style
        Core.shared.setAttributesSwitch(switchControl: notificationOutagesSwitch)
        Core.shared.setAttributesSwitch(switchControl: scheduledOutagesSwitch)
        Core.shared.setAttributesSwitch(switchControl: billOutagesSwitch)
        Core.shared.setAttributesSwitch(switchControl: billExpiredOutagesSwitch)
        Core.shared.setAttributesSwitch(switchControl: cancelableServiceOutagesSwitch)
        Core.shared.setAttributesSwitch(switchControl: serviceRestablishmentOutagesSwitch)
        
        
        print(Singleton.shared.getSwitchValues(number: 1))
        //Core.shared.setAttributesSwitch(switchControl: billExpiredOutagesSwitch)
    }
    
    func setUpActions(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
    }
    
    //Set Data
    func setData(data: [UserSettingsData]){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        data.forEach { settings in
            switch settings.prefName {
            case 1.description:
                weak.notificationOutagesSwitch.isOn = settings.prefValue
                Singleton.shared.setSwitchValues(isSet: settings.prefValue, number: 1)
            case 2.description:
                weak.scheduledOutagesSwitch.isOn = settings.prefValue
                Singleton.shared.setSwitchValues(isSet: settings.prefValue, number: 2)
            case 3.description:
                weak.billOutagesSwitch.isOn = settings.prefValue
                Singleton.shared.setSwitchValues(isSet: settings.prefValue, number: 3)
            case 4.description:
                weak.billExpiredOutagesSwitch.isOn = settings.prefValue
                Singleton.shared.setSwitchValues(isSet: settings.prefValue, number: 4)
            case 5.description:
                weak.cancelableServiceOutagesSwitch.isOn = settings.prefValue
                Singleton.shared.setSwitchValues(isSet: settings.prefValue, number: 5)
            case 6.description:
                weak.serviceRestablishmentOutagesSwitch.isOn = settings.prefValue
                Singleton.shared.setSwitchValues(isSet: settings.prefValue, number: 6)
                
            default:
                print("Error no existe ubn valor o switch")
            }
        }
    }
    
    //Swtich actions
    @IBAction func switch1Action(_ sender: UISwitch) {
        Singleton.shared.setSwitchValues(isSet: sender.isOn, number: 1)
    }
    
    @IBAction func switch2Action(_ sender: UISwitch) {
        Singleton.shared.setSwitchValues(isSet: sender.isOn, number: 2)
    }
    
    @IBAction func switch3Action(_ sender: UISwitch) {
        Singleton.shared.setSwitchValues(isSet: sender.isOn, number: 3)
    }
    
    @IBAction func switch4Action(_ sender: UISwitch) {
        Singleton.shared.setSwitchValues(isSet: sender.isOn, number: 4)
    }
    
    @IBAction func switch5Action(_ sender: UISwitch) {
        Singleton.shared.setSwitchValues(isSet: sender.isOn, number: 5)
    }
    
    @IBAction func switch6Action(_ sender: UISwitch) {
        Singleton.shared.setSwitchValues(isSet: sender.isOn, number: 6)
    }
    
    //Dimiss action
    @IBAction func dimissAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        dismiss(animated: true, completion: nil)
    }
    
    //Change password action
    @IBAction func changePasswordAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let email = Singleton.shared.checkValueSet(key: K.defaultKeys.others.email)
        if  email != ""{
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                guard let errorInstanced = error else{
                    
                    Core.shared.alert(message: K.messages.passwordUpdated, title: K.titles.alertSuccessTitle, at: weak)
                    
                    return
                }
                
                Core.shared.alert(message: K.messages.passwordUpdatedWrong, title: K.titles.alertWrongTitle, at: weak)
                
            }
        }
        
        
    }
    
    //Sign Out action
    @IBAction func signOutAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        Singleton.shared.resetUser()
        Core.shared.performSegue(controller: weak, identifier: K.segues.profile.signOutSegue)
    }
    
    //save
    @IBAction func saveAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        DispatchQueue.main.async {
            weak.updateUserSettingsManager(id: "1", pref: Singleton.shared.getSwitchValues(number: 1))
            weak.updateUserSettingsManager(id: "1", pref: Singleton.shared.getSwitchValues(number: 2))
            weak.updateUserSettingsManager(id: "1", pref: Singleton.shared.getSwitchValues(number: 3))
            weak.updateUserSettingsManager(id: "1", pref: Singleton.shared.getSwitchValues(number: 4))
            weak.updateUserSettingsManager(id: "1", pref: Singleton.shared.getSwitchValues(number: 5))
            weak.updateUserSettingsManager(id: "1", pref: Singleton.shared.getSwitchValues(number: 6))
        }
        
    }
    
    
    //API
    //-- Get Payment Options
    private func userSettings(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        weak.customLoading()
        
        
        UserSettingsManager().userSettings(header: weak.headerUser) {
            response in
            weak.stopAnimating()
            guard let settings = response, ((response?.data) != nil) else{
                
                return
                
            }
            
            
            switch settings.message{
            case ResponseMessages.success.message:
                if !settings.data.isEmpty{
                    weak.setData(data: settings.data)
                }
                
                break
                
            default:
                weak.stopAnimating()
                return
            }
            
            
        }
    }
    
    //-- Update settings.
    private func updateUserSettingsManager(id:String, pref: Bool){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        weak.customLoading()
        
        let params: Parameters =
            ["pref_id":"1",
             "pref_val": pref as? NSString as Any 
        ]
        
        
        UserSettingsManager().updateUserSettings(header: headerUser, params: params) {
            response in
            guard let settings = response else{
                weak.ifError = true
                weak.stopAnimating()
                weak.checkState()
                return
            }
            
            switch settings.message{
            case ResponseMessages.doneRegistered.message:
                weak.stopAnimating()
                weak.ifError = false
                weak.current += 1
                weak.checkState()
                break
                
            default:
                weak.stopAnimating()
                weak.ifError = true
                weak.checkState()
                return
            }
            
            
        }
    }
    
    
    func checkState(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        if current == 6 && !ifError{
            Core.shared.alert(message: "La configuración fue actualizada", title: K.titles.alertSuccessTitle, at: weak)
        }
        else if current == 6 && ifError{
            Core.shared.alert(message: "Uno o más datos no pudieron ser actualizados", title: K.titles.alertWrongTitle, at: weak)
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

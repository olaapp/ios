//
//  Singleton.swift
//  AESApp
//
//  Created by Alex on 4/27/20.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

struct Global{
    let defaults = UserDefaults.standard
    let loginManager = LoginManager()
}

class Singleton {
    
    // MARK: - Let-Var
    static let shared = Singleton()
    private init() {}
    
    // MARK: - Single singleton callers
       
    //------               Setters                     ----/
       
    
    //keep  user logged
    func saveSignInState(isSet: Bool){
        Global().defaults.set(
            isSet,
            forKey:K.defaultKeys.auth.signIn)
    }
    
    //Welcome
    func saveWelcomeState(isSet: Bool){
        Global().defaults.set(
            isSet,
            forKey:K.defaultKeys.others.setWelcome)
    }
    
    //Auth token
    func setOauthToken(accessToken: String?){
        Global().defaults.set(accessToken, forKey:K.defaultKeys.auth.token)
    }
    
    //Auth Names
    func setNames(name: String?, lastName: String?){
        Global().defaults.set(name, forKey:K.defaultKeys.others.names)
        Global().defaults.set(lastName, forKey:K.defaultKeys.others.lastNames)
    }
    
    //Email
    func setEmail(email: String){
        Global().defaults.set(email, forKey:K.defaultKeys.others.email)
    }
    
    
    //Notification token
    func setPushToken(token: String?){
        Global().defaults.set(token, forKey:K.defaultKeys.auth.fcmToken)
    }
    
    //keep  user logged
    func tutorialDone(isSet: Bool){
        Global().defaults.set(
            isSet,
            forKey:K.defaultKeys.others.tutorial)
    }
    
    //keep  user logged
    func news(isSet: Bool){
        Global().defaults.set(
            isSet,
            forKey:K.defaultKeys.consultation.news)
    }
    
    //Func set phone
    func setPhone(_ phone: String){
        Global().defaults.set(phone, forKey:K.defaultKeys.others.setPhone)
    }
    
    //Func set calculator value
    func setCalculatorValue(data: [Calculate]){
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.setCalculatorValue)
    }
    
    //Departamentos
    func setDepartamentsArray( data: [DatosDepartamentos]){
        
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.departamentos)
    }
    
    //Cities
    func setCitiesArray(data: [DatosMunicipios]){
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.municipios)
    }
    
    
    //Transactions
    func setTransactionsArray(data: [TransaccionResponseData]){
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.transactions)
    }
    
    //Cities
    func setAppOptionsArray(data: [ReadAppOptionsResponseData]){
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.appOptions)
    }
    
    //Type documents new services
    func setDocumentsNewServicesArray(data: [TypeNewServiceData]){
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.setDocumentsNewServices)
    }
    
    //Type status new services
    func setStatusNewServicesArray(data: [TypeNewServiceData]){
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.setStatusNewServices)
    }
    
    //Set a new service
    func setNewServices(data: SetNewService){
        let data = try! JSONEncoder().encode(data)
        Global().defaults.set(data, forKey: K.defaultKeys.others.setNewServices)
    }
    
    //--Switch preferences
    
    //Switch value
    func setSwitchValues(isSet: Bool, number: Int){
        switch number {
        case 1:
            Global().defaults.set(
                isSet,
                forKey:K.defaultKeys.switchValues.switch1)
        case 2:
            Global().defaults.set(
                isSet,
                forKey:K.defaultKeys.switchValues.switch2)
        case 3:
            Global().defaults.set(
                isSet,
                forKey:K.defaultKeys.switchValues.switch3)
        case 4:
            Global().defaults.set(
                isSet,
                forKey:K.defaultKeys.switchValues.switch4)
        case 5:
            Global().defaults.set(
                isSet,
                forKey:K.defaultKeys.switchValues.switch5)
            
        case 6:
            Global().defaults.set(
                isSet,
                forKey:K.defaultKeys.switchValues.switch6)
            
        default:
            print("Erros setting switch preference")
        }
    }
    
    
    //------               Getters                     ----/
    
    //Check if isPresented at Consultation COntroller
    func checkKeyState(key: String) -> Bool {
        let isSet = Global().defaults.object(forKey: key) as? Bool
        return isSet == nil ? false : isSet!
    }
    
    //Calling a key for a user
    func checkValueSet(key: String) -> String {
        let str = Global().defaults.object(forKey: key) as? String
        return str == nil ? "" : str!
    }
    
    //Calling a key for a user
    func checkPushToken() -> String {
        let str = Global().defaults.object(forKey: K.defaultKeys.auth.fcmToken) as? String
        return str == nil ? "push_tok" : str!
    }
    
    //Calling a key for a user
    func removeValueSet(key: String) {
        Global().defaults.removeObject(forKey:key)
    }
    
    //Check if  calculator value
    func getCalculatorValue() -> [Calculate]?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.setCalculatorValue)
        
        var array = [Calculate]()
        
        if let dataInstance = data{
            array = try! JSONDecoder().decode([Calculate].self, from: dataInstance)
        }
        
        return array
    }
    
    //Check if is Departaments are presented
    
    func getDepartaments() -> [DatosDepartamentos]?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.departamentos)
        
        var array = [DatosDepartamentos]()
        
        if let dataInstance = data{
            array = try! JSONDecoder().decode([DatosDepartamentos].self, from: dataInstance)
        }
        
        return array
    }
    
    //Check if is Municipios are presented
    
    func getMunicipios() -> [DatosMunicipios]?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.municipios)
    
        var array = [DatosMunicipios]()
        
        if let dataInstance = data{
            array = try! JSONDecoder().decode([DatosMunicipios].self, from: dataInstance)
        }
        return array
    }
    
    
    //Check if is transactions are presented
    
    func getTransactions() -> [TransaccionResponseData]?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.transactions)
    
        var array = [TransaccionResponseData]()
        
        if let dataInstance = data{
            array = try! JSONDecoder().decode([TransaccionResponseData].self, from: dataInstance)
        }
        return array
    }
    
    
    //Check app options 
    
    func getAppOptions () -> [ReadAppOptionsResponseData]?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.appOptions)
    
        var array = [ReadAppOptionsResponseData]()
        
        if let dataInstance = data{
            array = try! JSONDecoder().decode([ReadAppOptionsResponseData].self, from: dataInstance)
        }
        return array
    }
    
    //Check documents new services
    
    func getDocumentsNewServices () -> [TypeNewServiceData]?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.setDocumentsNewServices)
    
        var array = [TypeNewServiceData]()
        
        if let dataInstance = data{
            array = try! JSONDecoder().decode([TypeNewServiceData].self, from: dataInstance)
        }
        return array
    }
    
    //Check documents new services
    
    func getStatusNewServices () -> [TypeNewServiceData]?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.setStatusNewServices)
    
        var array = [TypeNewServiceData]()
        
        if let dataInstance = data{
            array = try! JSONDecoder().decode([TypeNewServiceData].self, from: dataInstance)
        }
        return array
    }
    
    //Switch value
    func getSwitchValues(number: Int)-> Bool {
        
        switch number {
        case 1:
            let isSet = Global().defaults.object(forKey: K.defaultKeys.switchValues.switch1) as? Bool
            return isSet == nil ? false : isSet!
        case 2:
            let isSet = Global().defaults.object(forKey: K.defaultKeys.switchValues.switch2) as? Bool
            return isSet == nil ? false : isSet!
        case 3:
            let isSet = Global().defaults.object(forKey: K.defaultKeys.switchValues.switch3) as? Bool
            return isSet == nil ? false : isSet!
        case 4:
            let isSet = Global().defaults.object(forKey: K.defaultKeys.switchValues.switch4) as? Bool
            return isSet == nil ? false : isSet!
        case 5:
            let isSet = Global().defaults.object(forKey: K.defaultKeys.switchValues.switch5) as? Bool
            return isSet == nil ? false : isSet!
            
        case 6:
            let isSet = Global().defaults.object(forKey: K.defaultKeys.switchValues.switch6) as? Bool
            return isSet == nil ? false : isSet!
            
        default:
            return false
        }
    }
    
    
    
    //Check New services
    
    func getNewServices() -> SetNewService?{
        let data = UserDefaults.standard.data(forKey: K.defaultKeys.others.setNewServices)
        
        var newServices:SetNewService?
        
        if let dataInstance = data{
            newServices = try! JSONDecoder().decode(SetNewService.self, from: dataInstance)
        }
        
        return newServices
    }
    
    //------               Delete                     ----/
    
    
    //Deleting user settings
    func resetUser(){
        Global().defaults.removeObject(forKey:K.defaultKeys.auth.token)
        Global().defaults.removeObject( forKey:K.defaultKeys.auth.signIn)
        Global().defaults.removeObject( forKey:K.defaultKeys.consultation.isPresented)
        Global().defaults.removeObject( forKey:K.defaultKeys.others.names)
        Global().defaults.removeObject( forKey:K.defaultKeys.others.lastNames)
        Global().defaults.removeObject( forKey:K.defaultKeys.others.appOptions)
        facebookSignOut()
        firebaseSignOut()
    }
    
    func facebookSignOut(){
        Global().loginManager.logOut()
    }
    
    func firebaseSignOut(){
        let firebaseAuth = Auth.auth()
        do {
            print("DONE OUT")
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: ", signOutError)
        }
    }
}

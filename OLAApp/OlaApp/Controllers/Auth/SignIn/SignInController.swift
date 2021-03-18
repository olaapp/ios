//
//  SignInController.swift
//  AESApp
//
//  Created by Alex on 4/27/20.
//

import UIKit
import MaterialComponents
import GoogleSignIn
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import PopupDialog
import Alamofire
import NVActivityIndicatorView
import LocalAuthentication

class SignInController: UIViewController, NVActivityIndicatorViewable {
    
    
    // MARK: - Let-Var
    
    //--Facebook
    var facebookUser: FacebookUser?
    let loginManager = LoginManager()
    let readPermissions:[Permission] = [ .publicProfile, .email]
    var isPresented = Bool()
    var fromModal = Bool()
    var fromManagaments = Bool()
    
    open var header: HTTPHeaders{
        return ["Content-Type": "application/json"]
    }

    
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var recoveryPasswordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var topCircleImages: UIImageView!
    
    
    //--Constraint
    @IBOutlet weak var topLogo: NSLayoutConstraint!
    @IBOutlet weak var topWelcomeLabel: NSLayoutConstraint!
    @IBOutlet weak var topTextFields: NSLayoutConstraint!
    @IBOutlet weak var topSignInButton: NSLayoutConstraint!
    @IBOutlet weak var topsSeparatorline: NSLayoutConstraint!
    
    
    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // setting up general actions/delegates/Core
        setUpActions()
               
        // setting up UI elements to be used through the code
        setUpUI()
        
        
    }
    
    //Set fullscreen
    override open var prefersStatusBarHidden: Bool {return true}
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){
        
        //--Set attributed title on recoveryPasswordButton
        Core.shared.attributedtextButton(button: recoveryPasswordButton, string1: K.titles.recoveryButton.text1, string2: K.titles.recoveryButton.text2)
        
        //Modify constraints
        Core.shared.setCustomConstraintsByDevice(constraint: topLogo, constant: 100)
        Core.shared.setCustomConstraintsByDevice(constraint: topWelcomeLabel, constant: 50)
        Core.shared.setCustomConstraintsByDevice(constraint: topTextFields, constant: 45)
        Core.shared.setCustomConstraintsByDevice(constraint: topSignInButton, constant: 95)
        Core.shared.setCustomConstraintsByDevice(constraint: topsSeparatorline, constant: 26)
        
    }

    func setUpActions(){
        
        //Setting textfield outlined
        //--Email textfield
        Core.shared.attributesMDCOutlinedTextField(textfield: emailTextField,labelText: TextFieldText.email.label, placeholder: nil)
        emailTextField.keyboardType = .emailAddress
        
        //--Password textfield
        Core.shared.attributesMDCOutlinedTextField(textfield: passwordTextField,labelText: TextFieldText.password.label, placeholder: nil)
        passwordTextField.isSecureTextEntry = true
        
        
        
    }
    
    
    //Custom loading
    func customLoading(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let size = CGSize(width: 32, height: 32)
        weak.startAnimating(size, message: "", type: NVActivityIndicatorType.circleStrokeSpin)
    }
    
    
    //Dimiss action
    @IBAction func dimissAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        Core.shared.buttonAnimation(sender: sender)
        
        if fromManagaments{
            
            weak.dismiss(animated: true, completion: nil)
            
            if let tabBarController = weak.presentingViewController as? UITabBarController {
                tabBarController.selectedIndex = 0
            }
        }else{
            weak.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //Biometic signIn
    @IBAction func bioMetricAuthAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        Core.shared.buttonAnimation(sender: sender)
        customLoading()
        authenticationWithTouchID()
    }
    
    
   
    //Google signIn
    
    @IBAction func googleSignInAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        Core.shared.buttonAnimation(sender: sender)
        Core.shared.delegateGoogleSignIn(delegateeGIDSignIn: weak, controller: weak)
    }
    
    
    //Facebook signIn
    @IBAction func facebookSignInAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        customLoading()
        loginManager.logIn(permissions: readPermissions, viewController: weak) {
            loginResult in
            weak.stopAnimating()
            guard case .success = loginResult else {
                print("Error LOGIN FACEBOOK")
                print(loginResult)
                return
            }
            
            guard let accessToken = AccessToken.current else { return }
            let facebookAPIManager = FacebookAPIManager(accessToken: accessToken)
            
            facebookAPIManager.requestFacebookUser {
                facebookUser in
                guard let weak = weakSelf else{return}
                weak.facebookUser = facebookUser
                
                
                    let userID = accessToken.userID
                    guard let facebookFirstName = facebookUser.firstName else{return}
                    guard let facebookLastName = facebookUser.lastName else{return}
                    guard let facebookEmail = facebookUser.email else{return}
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                    
                Auth.auth().signIn(with: credential, completion: { (user, error)  in
                    guard let errorInstanced = error else{
                        if weak.isPresented || weak.fromManagaments{

                            weak.registerUser(
                            email: facebookEmail,
                            password: facebookEmail,
                            name: facebookFirstName,
                            last_name: facebookLastName,
                            birthday: "",
                            provider: "Facebook",
                            firebase_uuid: user?.user.uid ?? "0",
                            push_tok: Singleton.shared.checkPushToken(),
                            phone_number: "",
                            phone_language: "",
                            type: .fb)

                        }
                        
                        
                        return
                    }
                    
                    
                    Core.shared.alert(message: K.messages.facebookIssue, title: K.titles.alertWrongTitle, at: weak)
                    
                })
            }
        }
        
    }
    
    
    
    //Email signin
    @IBAction func emailSignInAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        Core.shared.buttonAnimation(sender: sender)
        
        guard let email = emailTextField.text, !emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else{
            Core.shared.alert(message: K.messages.emptyEmail, title: K.titles.alertWrongTitle, at: weak)
            return
        }
        
        guard let password = passwordTextField.text, !passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else{
            Core.shared.alert(message: K.messages.emptyPassword, title: K.titles.alertWrongTitle, at: weak)
            return
        }
        
        if Core.shared.emailValid(email) {
            weak.emailSignIn(email: email, password: password)
        }else{
            Core.shared.alert(message: K.messages.badEmail, title: K.titles.alertWrongTitle, at: weak)
        }
    }
    
    
    
    func emailSignIn(email:String, password:String){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        Auth.auth().signIn(withEmail: email, password: password) { data, error in
            
            guard let errorInstanced = error else{
                if weak.isPresented{
                    weak.signInUser(email, password)
                }
                return
            }
            
            
            switch AuthErrorCode(rawValue: errorInstanced._code) {
            case .wrongPassword:
                Core.shared.showCustomPopUp(controller: weak, title: K.titles.alertWrongTitle, issue: true, message: K.messages.wrongPassword)
            case .userNotFound:
                weak.createUser(email: email, password: password)
            default:
                print(errorInstanced)
            }
            
        }
    }
    
    //Biometric
    func authenticationWithTouchID() {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Usar su código:"

        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                weak.stopAnimating()
                if success {
                    
                    //Auth anonymous
                    Auth.auth().signInAnonymously() { (authResult, error) in
                        guard let errorInstanced = error else{
                            print(authResult?.user.uid)
                            if let uid = authResult?.user.uid{
                                let pushToken = Singleton.shared.checkPushToken()
                                weak.userAnonymous(uid, pushToken, "")
                            }
                            
                            return
                        }
                        DispatchQueue.main.async() {
                            Core.shared.alert(message: K.messages.authBiometricIssue, title: K.titles.alertWrongTitle, at: weak)
                        }
                    }
                    
                } else {
                    // Failed to authenticate
                    DispatchQueue.main.async() {
                        Core.shared.alert(message: K.messages.authBiometricIssue, title: K.titles.alertWrongTitle, at: weak)
                    }
                
                }
            }
        } else {
            weak.stopAnimating()
            guard let error = authorizationError else {
                return
            }
            print(error)
            DispatchQueue.main.async() {
                Core.shared.alert(message: K.messages.authBiometricIssue, title: K.titles.alertWrongTitle, at: weak)
            }
        }
    }
    
    
    func createUser(email:String, password:String){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        customLoading()
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            weak.stopAnimating()
            
            guard let errorInstanced = error else{
                weak.registerUser(
                    email: email,
                    password: password,
                    name: "",
                    last_name: "",
                    birthday: "",
                    provider: user?.credential?.provider ?? "Email-passsword",
                    firebase_uuid: user?.user.uid ?? "0",
                    push_tok: Singleton.shared.checkPushToken(),
                    phone_number: "",
                    phone_language: "",
                    type: .email)
                return
            }
            
           switch AuthErrorCode(rawValue: errorInstanced._code) {
            case .weakPassword:
             Core.shared.showCustomPopUp(controller: weak, title: K.titles.alertWrongTitle, issue: true, message: K.messages.weakPassword)
            default:
                print(errorInstanced)
            }
            
        
        }
    }
    
    
    //API
    //--SigIn Users
    func signInUser(_ email: String, _ password: String){
        customLoading()
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let params: Parameters =
            ["email":email,
            "password": password]
        
        UserManager().signInUser(header: header, params: params) {
            response in
            
            weak.stopAnimating()
            
            guard let auth = response else{ return}
            
            switch auth.message{
                
            case AuthMessages.done.message:
                Singleton.shared.saveSignInState(isSet: true)
                Singleton.shared.setOauthToken(accessToken: auth.authToken)
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
    
    //--Register Users
    func registerUser(email: String,
                      password: String,
                      name: String,
                      last_name: String,
                      birthday: String,
                      provider: String,
                      firebase_uuid: String,
                      push_tok: String,
                      phone_number: String,
                      phone_language: String,
                      type:AuthRequired){
        
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        customLoading()
        
        
        var params: Parameters = [:]
        
        switch type {
            
        case .email:
            params =
            ["email": email,
            "password": password,
            "provider": provider,
            "firebase_uuid": firebase_uuid,
            "push_tok": push_tok,
            "phone_language": phone_language ]
            break
            
        case .fb:
            params =
            ["email": email,
            "password": password,
            "name": name,
            "last_name": last_name,
            "birthday": birthday,
            "provider": provider,
            "firebase_uuid": firebase_uuid,
            "push_tok": push_tok,
            "phone_number": phone_number,
            "phone_language": phone_language ]
            break
        case .google:
            params =
            ["email": email,
            "password": password,
            "name": name,
            "last_name": last_name,
            "birthday": birthday,
            "provider": provider,
            "firebase_uuid": firebase_uuid,
            "push_tok": push_tok,
            "phone_number": phone_number,
            "phone_language": phone_language ]
            
            break
        default:
            return
        }
        
        
        UserManager().registerUser(header: header, params: params) {
            response in
            weak.stopAnimating()
            guard let auth = response else{ return}
            
            if type == .email{
                Singleton.shared.setEmail(email: email)
            }
            
            switch auth.message{
                
            case AuthMessages.doneRegisted.message:
                Singleton.shared.saveSignInState(isSet: true)
                Singleton.shared.setOauthToken(accessToken: auth.authToken)
                if type == .google || type == .fb{
                    Core.shared.performSegue(controller: weak, identifier: K.segues.auth.siginInToMainController)
                }else{
                    if (weak.fromModal){
                        Core.shared.performSegue(controller: weak, identifier: K.segues.auth.siginInToMainController)
                    }else{
                        weak.dismiss(animated: true, completion: nil)
                    }
                    
                }
                break
            case AuthMessages.done.message:
                Singleton.shared.saveSignInState(isSet: true)
                Singleton.shared.setOauthToken(accessToken: auth.authToken)
                if type == .google || type == .fb{
                Core.shared.performSegue(controller: weak, identifier: K.segues.auth.siginInToMainController)
                }else{
                    if (weak.fromModal){
                        Core.shared.performSegue(controller: weak, identifier: K.segues.auth.siginInToMainController)
                    }else{
                        weak.dismiss(animated: true, completion: nil)
                    }
                }
                break
            default:
                weak.stopAnimating()
                return
            }
        }
    }
    
    
    //--Users Anonymous
    func userAnonymous(_ firebase_uuid: String, _ push_tok: String, _ phone_language: String){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        customLoading()
        
        let params: Parameters =
        ["firebase_uuid": firebase_uuid,
         "push_tok": push_tok,
         "phone_language": phone_language ]
        
        print(firebase_uuid)
        
        UserManager().registerUserAsAnonymous(header: header, params: params) {
            response in
            
            weak.stopAnimating()
            
            guard let auth = response else{ return}
            
            switch auth.message{
                
            case AuthMessages.done.message:
                print("Ok")
                Singleton.shared.saveSignInState(isSet: true)
                Singleton.shared.setOauthToken(accessToken: auth.authToken)
                //weak.dismiss(animated: true, completion: nil)
                Core.shared.performSegue(controller: weak, identifier: K.segues.auth.siginInToMainController)
                break
                
            case AuthMessages.doneRegisted.message:
                print("Ok")
                Singleton.shared.saveSignInState(isSet: true)
                Singleton.shared.setOauthToken(accessToken: auth.authToken)
                //weak.dismiss(animated: true, completion: nil)
                Core.shared.performSegue(controller: weak, identifier: K.segues.auth.siginInToMainController)
                break
                
            case AuthMessages.notRegistered.message:
                DispatchQueue.main.async() {
                    Core.shared.alert(message: K.messages.authBiometricIssue, title: K.titles.alertWrongTitle, at: weak)
                }
                break
            default:
                return
            }
        }
    }
    

}


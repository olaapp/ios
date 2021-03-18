//
//  AppDelegate.swift
//  AESApp
//
//  Created by Alex on 4/28/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import GoogleMaps
import Alamofire
import FirebaseInstanceID
import FirebaseAuth
import OneSignal
import ETBinding

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate,
UNUserNotificationCenterDelegate, OSPermissionObserver, OSSubscriptionObserver{
    
    // MARK: - Let-Var
    open var header: HTTPHeaders{
        return ["Content-Type": "application/json"]
    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        

        // The promptForPushNotifications function code will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 6)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
          print("User accepted notifications: \(accepted)")
        })
        
        let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()

        let hasPrompted = status.permissionStatus.hasPrompted
        print("hasPrompted = \(hasPrompted)")
        if hasPrompted == false {
          OneSignal.addTrigger("prompt_ios", withValue: "true")
        }
        
        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
            
            print("Received Notification: ", notification!.payload.notificationID!)
            print("launchURL: ", notification?.payload.launchURL ?? "No Launch Url")
            print("content_available = \(notification?.payload.contentAvailable ?? false)")
            
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            let storyboard = UIStoryboard(name: K.storyboards.menu, bundle: nil)

            // instantiate the view controller from storyboard
            if  let vc = storyboard.instantiateViewController(withIdentifier: K.instances.mainTabBarController) as? MainTabBarController {
                guard let payloadInstanced = notification?.payload else{return}
                vc.selectedIndex = 0
                if let nvc = vc.viewControllers?[0] as? ConsultationController {
                    nvc.notificationPush = true
                    nvc.titleMessage = payloadInstanced.title ?? "Sin título disponible"
                    nvc.bodyMessage = payloadInstanced.body ?? "Sin mensaje disponible"
                    NotificationPushModelData.shared.liveData.data = NotificationPush(ready: true, title: payloadInstanced.title ?? "Sin título disponible", body: payloadInstanced.body ?? "Sin mensaje disponible")
                }
                
                keyWindow?.rootViewController = vc
                
            }
        }
        
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            // This block gets called when the user reacts to a notification received
            let payload: OSNotificationPayload? = result?.notification.payload
            
            
            print("Message: ", payload!.body!)
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            let storyboard = UIStoryboard(name: K.storyboards.menu, bundle: nil)

            // instantiate the view controller from storyboard
            if  let vc = storyboard.instantiateViewController(withIdentifier: K.instances.mainTabBarController) as? MainTabBarController {
                guard let payloadInstanced = payload else{return}
                vc.selectedIndex = 0
                if let nvc = vc.viewControllers?[0] as? ConsultationController {
                    nvc.notificationPush = true
                    nvc.titleMessage = payloadInstanced.title ?? "Sin título disponible"
                    nvc.bodyMessage = payloadInstanced.body ?? "Sin mensaje disponible"
                    NotificationPushModelData.shared.liveData.data = NotificationPush(ready: true, title: payloadInstanced.title ?? "Sin título disponible", body: payloadInstanced.body ?? "Sin mensaje disponible")
                }
                
                keyWindow?.rootViewController = vc

            }
             
        }
        
        //START OneSignal initialization code
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: true]
        
        // Replace 'YOUR_ONESIGNAL_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: K.oneSignal,
                                        handleNotificationReceived: notificationReceivedBlock,
                                        handleNotificationAction: notificationOpenedBlock,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        
        
        
        // Add your AppDelegate as an obsserver
        OneSignal.add(self as OSPermissionObserver)
        
        OneSignal.add(self as OSSubscriptionObserver)
        
        
        //END OneSignal initializataion code
        
        
        //Enabling firebase
        FirebaseApp.configure()
        
        
        //Enabling google sign in
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        //Enabling Facebook
        //Facebook delegate
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        //Enable api key for using Gmaps
        GMSServices.provideAPIKey(K.gmsServices)
        
        //Enabling our own keyboard
        IQKeyboardManager.shared.enable = true
        
        if let pushToken = status.subscriptionStatus.pushToken{
            Singleton.shared.setPushToken(token: pushToken)
        }
        
        return true
    }
    
    // Add this new method
    func onOSPermissionChanged(_ stateChanges: OSPermissionStateChanges!) {
        
        // Example of detecting answering the permission prompt
        if stateChanges.from.status == OSNotificationPermission.notDetermined {
            if stateChanges.to.status == OSNotificationPermission.authorized {
                print("Thanks for accepting notifications!")
            } else if stateChanges.to.status == OSNotificationPermission.denied {
                print("Notifications not accepted. You can turn them on later under your iOS settings.")
            }
        }
        // prints out all properties
        print("PermissionStateChanges: ", stateChanges!)
    }
    
    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
        if !stateChanges.from.subscribed && stateChanges.to.subscribed {
            print("Subscribed for OneSignal push notifications!")
        }
        print("SubscriptionStateChange: ", stateChanges!)
    }
    
    
    //API
    //--Load App Options
    func loadAppOptions(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        OptionsManager().options(header: header) {
            response in
            
            guard let data = response, ((response?.data) != nil) else{ return}
            
            switch data.message{
            case ResponseMessages.success.message:
                
                if !data.data.isEmpty{
                    Singleton.shared.setAppOptionsArray(data: data.data)
                }
                
                
                break
                
            default:
                return
            }
            
        }
    }
    
    
    // MARK: - Facebook/Google handler
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication =  options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        
        let googleHandler = GIDSignIn.sharedInstance().handle(url )
        let facebookHandler = ApplicationDelegate.shared.application( app, open: url, sourceApplication: sourceApplication, annotation: annotation )
        
        
        return googleHandler || facebookHandler
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // MARK: - Google Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print("Registration succeeded! Token: ", token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration failed!")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // Firebase notification received
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
        
        // custom code to handle push while app is in the foreground
        print("Handle push from foreground\(notification.request.content.userInfo)")
        
        let dict = notification.request.content.userInfo["aps"] as! NSDictionary
        let d : [String : Any] = dict["alert"] as! [String : Any]
        let body : String = d["body"] as! String
        let title : String = d["title"] as! String
        print("Title:\(title) + body:\(body)")
        //self.showAlertAppDelegate(title: title,message:body,buttonTitle:"ok",window:self.window!)
        completionHandler([.alert, .badge, .sound])
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // if you set a member variable in didReceiveRemoteNotification, you  will know if this is from closed or background
        print("Handle push from background or closed")
    }
    
    func showAlertAppDelegate(title: String,message : String,buttonTitle: String,window: UIWindow){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        window.rootViewController?.present(alert, animated: false, completion: nil)
    }
    // Firebase ended here
}


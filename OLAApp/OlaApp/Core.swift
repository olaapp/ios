//
//  Core.swift
//  AESApp
//
//  Created by Alex on 4/27/20.
//

import Foundation
import UIKit
import MaterialComponents
import GoogleSignIn
import Spring
import CHIPageControl
import SwiftMessages
import VisualEffectView
import ImageSlideshow
import PopupDialog
import GoogleMaps
import CoreLocation
import EasyTipView
import Alamofire
import Charts
import ViewAnimator
import Firebase
import Lottie






class Core {

    // MARK: - Let-Var
    static let shared = Core()
    private init() {}
    
    
    //--Attributes to be used at MDCOutlinedTextField
    let attributesPlaceholder = [
    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1),
    NSAttributedString.Key.strokeWidth: -1.0] as [NSAttributedString.Key : Any]
    
    //--Attributes to be used at attributedtextButton
    let attributesText1 = [
    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1),
    NSAttributedString.Key.font: UIFont.init(name: K.font.fontRegular, size: 13) ?? UIFont.systemFont(ofSize: 12)] as [NSAttributedString.Key : Any]
    
    let attributesText2 = [
    NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5647058824, green: 0.768627451, blue: 0.3490196078, alpha: 1),
    NSAttributedString.Key.font: UIFont.init(name: K.font.fontBold, size: 12) ?? UIFont.systemFont(ofSize: 12)] as [NSAttributedString.Key : Any]
    //-----------------
    
    
    
    
    //MARK: - Functions
    //MARK: - UI
    
    //--Show Alert Message (function)
    func alert(message: String, title: String, at viewController: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: K.titles.textConfirmAlert, style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    //--Show Alert Message 2 option (function)
    func alertOptions(message: String, title: String, at viewController: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: K.titles.textConfirmAlert, style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    //-Set MDCOutlinedTextField
    func attributesMDCOutlinedTextField(
        textfield:MDCOutlinedTextField,
        labelText:String,
        placeholder:String?
        ) {
        
        textfield.setTextColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.editing)
        textfield.setTextColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.normal)
        let placeholderText = placeholder ?? labelText
        textfield.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributesPlaceholder)
        textfield.setNormalLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .normal)
        textfield.setNormalLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .editing)
        textfield.setFloatingLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .editing)
        textfield.setFloatingLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .normal)
        
        textfield.label.text = labelText
        textfield.setOutlineColor(UIColor.lightGray, for: MDCTextControlState.editing)
        textfield.setOutlineColor(UIColor.lightGray, for: MDCTextControlState.normal)
        textfield.sizeToFit()
        textfield.font = UIFont.init(name: K.font.fontRegular, size: 14)
        textfield.label.font = UIFont.init(name: K.font.fontBold, size: 12)
        textfield.rightViewMode = .always
        setIconTrailing(textfield: textfield, labelText: labelText)
    
    }
    
    //-Set MDCFilledTextField
    func attributesMDCFilledTextField(
        textfield:MDCFilledTextField,
        labelText:String,
        placeholder:String?
        ) {
        
        textfield.setTextColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.editing)
        textfield.setTextColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.normal)
        let placeholderText = placeholder ?? labelText
        textfield.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributesPlaceholder)
        textfield.setNormalLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .normal)
        textfield.setNormalLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .editing)
        textfield.setFloatingLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .editing)
        textfield.setFloatingLabelColor(#colorLiteral(red: 0.2941176471, green: 0.4549019608, blue: 0.5764705882, alpha: 1), for: .normal)
        
        textfield.label.text = labelText
        textfield.setUnderlineColor(UIColor.clear, for: MDCTextControlState.editing)
        textfield.setUnderlineColor(UIColor.clear, for: MDCTextControlState.normal)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .white
        textfield.sizeToFit()
        textfield.font = UIFont.init(name: K.font.fontRegular, size: 14)
        textfield.label.font = UIFont.init(name: K.font.fontBold, size: 12)
        textfield.rightViewMode = .always
        
        
        
        setIconTrailingMDCFilledTextField(textfield: textfield, labelText: labelText)
        setIconLeadingMDCFilledTextField(textfield: textfield, labelText: labelText)
    
    }
    
    //-Set right icon on MDCOutlinedTextField
    func setIconTrailing(
    textfield:MDCOutlinedTextField,
    labelText:String) {
        
        
        switch labelText {
            
        case TextFieldText.email.label:
            textfield.rightView = UIImageView(image: #imageLiteral(resourceName: "email"))
            break
            
        case TextFieldText.password.label:
            textfield.rightView = UIImageView(image: #imageLiteral(resourceName: "lock"))
            break
        case TextFieldText.phoneNumber.label:
            textfield.rightView = UIImageView(image: #imageLiteral(resourceName: "phone"))
            break
        default:
            break
        }
        
        //Only changing border
        switch labelText {
        case TextFieldText.startDate.label:
            textfield.setOutlineColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.editing)
            textfield.setOutlineColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.normal)
        case TextFieldText.endDate.label:
            textfield.setOutlineColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.editing)
            textfield.setOutlineColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.normal)
        case TextFieldText.historicalEmail.label:
            textfield.setOutlineColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.editing)
            textfield.setOutlineColor(#colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1), for: MDCTextControlState.normal)
        default:
            print("")
        }
        
    }
    
    
    //-Set right icon on MDCFilledTextField
    func setIconTrailingMDCFilledTextField(
    textfield:MDCFilledTextField,
    labelText:String) {
        
        
        switch labelText {
            
        case TextFieldText.NIC.label:
            textfield.rightView = UIImageView(image: #imageLiteral(resourceName: "home"))
            break
            
        case TextFieldText.lastBill.label:
            textfield.rightView = UIImageView(image: #imageLiteral(resourceName: "lock"))
            break
        case TextFieldText.phoneNumber.label:
            textfield.rightView = UIImageView(image: #imageLiteral(resourceName: "phone"))
            break
        default:
            break
        }
        
    }
    
    
    //-Set left icon on MDCFilledTextField
    func setIconLeadingMDCFilledTextField(
       textfield:MDCFilledTextField,
       labelText:String) {
        
        textfield.leftViewMode = .always
        
        switch labelText {
               
           case TextFieldText.customName.label:
               textfield.leftView = UIImageView(image: #imageLiteral(resourceName: "person"))
               break
           
           default:
               break
           }
           
       }
    
    
    //--Set attributed title on SignInController
    func attributedtextButton(button: UIButton, string1: String, string2: String) {
        
        

        let att = NSMutableAttributedString(string: "\(string1)\(string2)") ;
        
        
        att.addAttributes(
        attributesText1,
        range: NSRange(location: 0,
        length: string1.count))
        
        
        att.addAttributes(
        attributesText2,
        range: NSRange(location: string1.count,
        length: string2.count))
        
        button.setAttributedTitle(att, for: .normal)
    }
    
    //Set custom constraint by Device
    func setCustomConstraintsByDevice(constraint:NSLayoutConstraint, constant:CGFloat){
        
        
        if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")

            case 1334:
                print("iPhone 6/6S/7/8")

            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")

            case 2436:
                constraint.constant = constant

            case 2688:
                constraint.constant = constant

            case 1792:
                constraint.constant = constant

            default:
               constraint.constant = constant
            }
        }
    }
    
    //--Animate button
    func buttonAnimation(sender:UIButton){
        
        sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)

        UIView.animate(withDuration: 2.0,
                                   delay: 0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 3,
                                   options:
                                   [.curveEaseInOut,
                                   UIView.AnimationOptions.allowUserInteraction],
                                   animations: {
                                    sender.transform = CGAffineTransform.identity
            },
                                   completion: { Void in()  }
        )
        
    }
    
    //Set custom button on middle at tabbar
    func setMiddleButtonTabBar(view:UIView, button:SpringButton, tabBar: UITabBar){
        button.animation = K.animations.squeezeDown
        button.animate()
        button.setImage(#imageLiteral(resourceName: "center_button"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.layer.cornerRadius = 32
        button.isUserInteractionEnabled = false
        view.insertSubview(button, aboveSubview: tabBar)
    }
    
    //Set position at middle button
    func posisitonAtMiddleButton(view:UIView, button:SpringButton, tabBar: UITabBar){
        if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
            case 1136:
                 button.frame = CGRect.init(x: tabBar.center.x - 35, y: view.bounds.height - 74, width: 70, height: 70)

            case 1334:
                button.frame = CGRect.init(x: tabBar.center.x - 36, y: view.bounds.height - 79, width: 76, height: 76)

            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
               button.frame = CGRect.init(x: tabBar.center.x - 36, y: view.bounds.height - 85, width: 70, height: 70)

               
            case 2436:
                button.frame = CGRect.init(x: tabBar.center.x - 34, y: view.bounds.height - 110, width: 72, height: 72)

            case 2688:
               button.frame = CGRect.init(x: tabBar.center.x - 34, y: view.bounds.height - 85, width: 72, height: 72)

            case 1792:
                button.frame = CGRect.init(x: tabBar.center.x - 34, y: view.bounds.height - 85, width: 72, height: 72)

            default:
               button.frame = CGRect.init(x: tabBar.center.x - 34, y: view.bounds.height - 85, width: 72, height: 72)
            }
        }
    }
    
    //Change color on imageview
    func changeImageColor(image:UIImage, color:UIColor)-> UIImage{
        return image.withTintColor(color, renderingMode:.alwaysOriginal)
    }
    
    //Center image at button
    func centerImageAtButton(button: UIButton){
        button.imageView?.contentMode = .center
    }
    
    //Set attributes at pagecontrol
    func attributesPageControl(pageControl:CHIPageControlJalapeno){
        pageControl.radius = 4
        pageControl.tintColor = .lightGray
        pageControl.currentPageTintColor = .white
        pageControl.padding = 6
    }
    
   //Set blur
    func setBlur(view: UIView, visualEffectView: VisualEffectView){
        

        // Configure the view with tint color, blur radius, etc
        visualEffectView.colorTint = .lightGray
        visualEffectView.colorTintAlpha = 0.2
        visualEffectView.blurRadius = 10
        visualEffectView.scale = 1

        view.addSubview(visualEffectView)
          
    }
    
    //Slideshow Attributes
    func slideShowAttributes(
        slideShow: ImageSlideshow,
        pageControl:CHIPageControlJalapeno,
        label:UILabel,
        scrollViewDelegate: UIScrollViewDelegate){
        slideShow.pageIndicator = nil
        slideShow.addSubview(pageControl)
        slideShow.addSubview(label)
        slideShow.contentScaleMode = .scaleAspectFill
        slideShow.scrollView.isPagingEnabled = true
        slideShow.scrollView.delegate = scrollViewDelegate
        
    }
    
    
    //Set border with gradient
    func setGradientAtBorder(view:UIView, radius: CGFloat, borderWidth:CGFloat){
        let gradient = CAGradientLayer()
        let shape = CAShapeLayer()
        
        
        
        
        gradient.frame =  CGRect(origin: CGPoint.zero, size: view.frame.size)
        gradient.colors =
            [UIColor(red: 0.5, green: 0.74, blue: 0.25, alpha: 0.55).cgColor,
             UIColor(red: 0.0, green: 0.46, blue: 0.69, alpha: 0.19).cgColor]
        
        
        shape.lineWidth = 1
        shape.path = UIBezierPath(roundedRect: view.bounds.insetBy(dx: 2.5, dy: 2.5), cornerRadius: radius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.borderColor = UIColor.clear.cgColor
        gradient.mask = shape
        view.layer.addSublayer(gradient)
        
    }
    
    
    
    //Custom switch control
    func setAttributesSwitch(switchControl: UISwitch){
        switchControl.set(width: CGFloat.init(43.0), height: CGFloat.init(23.0))
        switchControl.onTintColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        switchControl.tintColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        switchControl.thumbTintColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1)
        switchControl.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        
        switchControl.layer.cornerRadius = 13
    }
    
    
    //Set current steo text
    func setCurrentStep(label:UILabel) {
        label.font = UIFont(name: K.font.fontBold, size: 12)!
    }
    
    //MARK: - Delegate Functions
    func delegateGoogleSignIn(delegateeGIDSignIn: GIDSignInDelegate, controller:UIViewController){
        DispatchQueue.main.async {
            GIDSignIn.sharedInstance()?.presentingViewController = controller
            GIDSignIn.sharedInstance().delegate = delegateeGIDSignIn
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    
    //Setting storyboards on TabPager
    func setStoryBoardName(storyboard: String, controller: String, at: UIViewController) -> UIViewController{
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: controller)
    }
    
    //Intance storyboard
    func instanceStoryboard(name:String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard
    }
    
    //instantiateViewController
    func instantiateViewController(at: UIStoryboard, identifier: String) -> UIViewController {
        let instanced =  at.instantiateViewController(withIdentifier: identifier)
        return instanced
        
    }
    
    //Set custom item at Tabbar
    func customItemTabbar(tabBar: UITabBar, position:Int, image:UIImage, edgeInsets: UIEdgeInsets){
        tabBar.items?[position].image = image
        tabBar.items?[position].selectedImage =
            changeImageColor(image: image, color: #colorLiteral(red: 0.5019607843, green: 0.737254902, blue: 0.2549019608, alpha: 1))
        tabBar.items?[position].title = ""
        
        
        let edgeInsetsPosition1 = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: -60)
        let edgeInsetsPosition2 = UIEdgeInsets(top: 5, left: -60, bottom: 0, right: 0)
        
        if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
            case 1136:
                 tabBar.items?[position].imageInsets = edgeInsets

            case 1334:
                tabBar.items?[position].imageInsets = edgeInsets

            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
               tabBar.items?[position].imageInsets = edgeInsets

               
            case 2436:
                if position == 1 {
                    tabBar.items?[0].imageInsets = edgeInsetsPosition1
                }else{
                    tabBar.items?[2].imageInsets = edgeInsetsPosition2
                }
                 

            case 2688:
               if position == 0 {
                   tabBar.items?[0].imageInsets = edgeInsetsPosition1
               }else{
                   tabBar.items?[2].imageInsets = edgeInsetsPosition2
               }
                

            case 1792:
                if position == 0 {
                    tabBar.items?[0].imageInsets = edgeInsetsPosition1
                }else{
                    tabBar.items?[2].imageInsets = edgeInsetsPosition2
                }
                 

            default:
               tabBar.items?[position].imageInsets = edgeInsets
            }
        }
    }
    
    
    
    //To set items to be used at InformationMenu CollectionView
    func setInformationMenuItems()-> InformationMenuItems{
        var informationMenuItems = InformationMenuItems()
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item1, image: #imageLiteral(resourceName: "information_item_1")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item2, image: #imageLiteral(resourceName: "information_item_3")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item3, image: #imageLiteral(resourceName: "tower")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item4, image: #imageLiteral(resourceName: "broken-cable")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item5, image: #imageLiteral(resourceName: "enviroment")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item6, image: #imageLiteral(resourceName: "idea_innovation")))
        return informationMenuItems
    }
    
    
    
    func setInformationMenuItemsManagements()-> InformationMenuItems{
        var informationMenuItems = InformationMenuItems()
       
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item8, image: #imageLiteral(resourceName: "information_item_5")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item9, image: #imageLiteral(resourceName: "support")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item10, image: #imageLiteral(resourceName: "see (1)")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item11, image: #imageLiteral(resourceName: "eco-friendly (1)")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item12, image: #imageLiteral(resourceName: "information_item_7")))
        informationMenuItems.append(InformationMenu(title: K.titles.InformationMenu.item13, image: #imageLiteral(resourceName: "thunder")))
        
        return informationMenuItems
    }
    
  
    
    //Performe Segue
    func performSegue(controller:UIViewController, identifier: String){
        controller.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    //Hide and remove action from view
    func hideView(view:UIView){
        view.isHidden = true
        view.isUserInteractionEnabled = false
    }
    
    
    //Show Auth Dialog
    func openAuthDialog(view: UIView,
                        visualEffectView: VisualEffectView?,
                        controller:UIViewController){
        setBlur(view: view, visualEffectView: visualEffectView!)

        controller.definesPresentationContext = true

        performSegue(controller: controller, identifier: K.segues.consultation.consultationToSignInAlert)
        
        
    }
    
    
    //No internet popup
    func noInternetPopUp(_ controller:UIViewController){
        // Create the dialog
        DispatchQueue.main.async {
            let popup = PopupDialog(
                title: K.titles.alertWrongTitle,
                message: K.messages.noInternet,
                image: nil,
                buttonAlignment: .horizontal,
                transitionStyle: .bounceUp,
                tapGestureDismissal: true
            )

            let button = DefaultButton(title: "Aceptar", height: 60) {}
            
            popup.addButtons([button])
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show custom popup
    func showCustomPopUp(controller:UIViewController,
                         title: String,
                         issue: Bool,
                         message: String){
        let popup = AlertMessage(nibName: K.NIB.alertMessage, bundle: nil)
        popup.titleText = title
        popup.issue = issue
        popup.message = message
        
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
            
            let buttonTwo = DefaultButton(title: "Aceptar", height: 60) {}
            
            popup.addButtons([buttonTwo])
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    
    //Show map popup
    func showMapPopUp(controller:UIViewController, lat: String, lon: String){
        let popup = AlertMapsDialog(nibName: K.NIB.alertMapsDialog, bundle: nil)
        popup.setLatitude = lat
        popup.setLongitude = lon
        
        
        DispatchQueue.main.async {
            // Create the dialog
            let alert = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: true)
            
            // Present dialog
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    //Show custom name popup
    func showCustomNamePopUp(controller:UIViewController){
        let popup = CustomNameDialog(nibName: K.NIB.customNameAlert, bundle: nil)
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: true)
            
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show filter popup
    func showFilterPopUp(controller:UIViewController){
        let popup = FilterDialog(nibName: K.NIB.filterDialog, bundle: nil)
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: true)
            
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show Edit profile popup
    func showEditProfilePopUp(controller:UIViewController){
        let popup = ProfileEditInfoAlert(nibName: K.NIB.profileEditInfoAlert, bundle: nil)
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: true)
            
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    
    //Show Consumption Alert
    func showConsumptionAlert(controller:UIViewController, message:String, kwh:String){
        let popup = ConsumptionAlert(nibName: K.NIB.consumptionAlert, bundle: nil)
        popup.kwH = kwh
        popup.message = message
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: true)
            
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }

    
    //Show Paymetn list Alert
    func showPaymentAlert(controller:UIViewController,data: [PaymentOptionsResponseData], nic:String){
        let popup = PaymentAlert(nibName: K.NIB.paymentAlert, bundle: nil)
        popup.data = data
        popup.nic = nic
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: true)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show Management First Alert
    func showManagementFirstAlert(controller:UIViewController, data: SetManagementsAccountResponse){
        
        let popup = ManagementFirstAlert(nibName: K.NIB.managementFirstAlert, bundle: nil)
        popup.setManagementsAccountResponse = data
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show Management Second Alert
    func showManagementSecondAlert(controller:UIViewController, data: SetManagementsAccountResponse){
        
        let popup = ManagementSecondAlert(nibName: K.NIB.managementSecondAlert, bundle: nil)
        popup.setManagementsAccountResponse = data
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show Management Third Alert
    func showManagementThirdAlert(controller:UIViewController, nic:String, data: SetManagementsAccountResponse){
        
        let popup = ManagementThirdAlert(nibName: K.NIB.managementThirdAlert, bundle: nil)
        popup.setManagementsAccountResponse = data
        popup.nic = nic
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show Management Fourth Alert
    func showManagementFourthAlert(controller:UIViewController, data: SetManagementsAccountResponse){
        
        let popup = ManagementFourthAlert(nibName: K.NIB.managementFourthAlert, bundle: nil)
        popup.setManagementsAccountResponse = data
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show Management Fifth Alert
    func showManagementFifthAlert(controller:UIViewController, data: SetManagementsAccountResponse){
        
        let popup = ManagementFirstAlert(nibName: K.NIB.managementFifthAlert, bundle: nil)
        popup.setManagementsAccountResponse = data
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    
    
    //Show Hazards Alert
    func showHazardsAlert(controller:UIViewController,
    nic:String,
    category:String,
    operation:String,
    comment:String,
    affected_neighborhood:String){
        
        let popup = SupplyNotServiceAlert(nibName: K.NIB.supplyNotServiceAlert, bundle: nil)
        popup.nic = nic
        popup.operation = operation
        popup.comment = comment
        popup.affected_neighborhood = affected_neighborhood
        popup.category = category
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show custom name popup
    func showCalculatorPopUp(id:String,name:String,kwh:String,controller:UIViewController){
        let popup = CalculatorAlert(nibName: K.NIB.calculatorAlert, bundle: nil)
        popup.name = name
        popup.kwh = kwh
        popup.id = id
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show new service popup
    func showNewServicesAlertPopUp(
        title:String,
        value:String,
        fieldValue:String,
        dataInstanced: NewServiceResponseData,
        controller:UIViewController){
        let popup = NewServicesAlert(nibName: K.NIB.newServicesAlert, bundle: nil)
        popup.serviceTitle = title
        popup.value = value
        popup.fieldValue = fieldValue
        popup.dataInstanced = dataInstanced
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show new service popup
    func showNewServicesDropDownAlertPopUp(
        title:String,
        value:String,
        fieldValue:String,
        dataInstanced: NewServiceResponseData,
        controller:UIViewController){
        let popup = NewServicesAlert2(nibName: K.NIB.newServicesAlert2, bundle: nil)
        popup.serviceTitle = title
        popup.value = value
        popup.fieldValue = fieldValue
        popup.dataInstanced = dataInstanced
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show new service popup
    func showNewServicesTextViewAlertPopUp(
        title:String,
        value:String,
        fieldValue:String,
        dataInstanced: NewServiceResponseData,
        controller:UIViewController){
        let popup = NewServicesAlert3(nibName: K.NIB.newServicesAlert3, bundle: nil)
        popup.serviceTitle = title
        popup.value = value
        popup.fieldValue = fieldValue
        popup.dataInstanced = dataInstanced
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Show new service popup
    func showNotificationsAlertPopUp(
        title:String,
        body:String,
        controller:UIViewController){
        let popup = NotificationPushDialog(nibName: K.NIB.notificationPushDialog, bundle: nil)
        popup.titleMessage = title
        popup.body = body
        
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
            
            // Present dialog
            controller.present(popup, animated: true, completion: nil)
        }
    }
    
    //Get calculator values
    func getCalculatorMachines(id:String) -> Int {
        var value = 0
        if let calculateArray = Singleton.shared.getCalculatorValue(){
            if !calculateArray.isEmpty{
                
                calculateArray.forEach { calculateData in
                    if calculateData.id == id{
                        value =  calculateData.machines
                    }else{
                        value =  0
                    }
                }
            }
        }
        return value
    }
    
    func getCalculatorResult(id:String) -> Int {
        var value = 0
        if let calculateArray = Singleton.shared.getCalculatorValue(){
            if !calculateArray.isEmpty{
                
                calculateArray.forEach { calculateData in
                    if calculateData.id == id{
                        value =  calculateData.total
                    }else{
                        value =  0
                    }
                }
            }
        }
        return value
    }
    
    //Open google maps
    func openGoogleMap(lat: Double, lon: Double) {
        
         if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app

             if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(lon)&directionsmode=driving") {
                       UIApplication.shared.open(url, options: [:])
              }}
         else {
                //Open in browser
               if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(lon)&directionsmode=driving") {
                                  UIApplication.shared.open(urlDestination)
                              }
                   }

    }
    
    //Open waze maps
    func openWaze(lat: Double, lon: Double) {
        if let url = URL(string: "waze://") {
            if UIApplication.shared.canOpenURL(url) {
                // Waze is installed. Launch Waze and start navigation
                let urlStr = "https://waze.com/ul?ll=\(lat),\(lon)&navigate=yes"
                if let url = URL(string: urlStr) {
                    UIApplication.shared.openURL(url)
                }
            } else {
                // Waze is not installed. Launch AppStore to install Waze app
                if let url = URL(string: "http://itunes.apple.com/us/app/id323229106") {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }

    
    //alexgonzalez_contreras@outlook.com
    
    func emailValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    //Hide tutorial views
    func hideTutorialViews(views:[UIView]){
        views.forEach { view in
            view.isHidden = true
        }
    }
    
   
    //Return Auth state
    func returnAuthState() -> Bool{
        return Singleton.shared.checkKeyState(key: K.defaultKeys.auth.signIn)
    }
    
    //Set map settings
    func setMapSettings(
        mapView:GMSMapView,
        controller:GMSMapViewDelegate){
        
        DispatchQueue.main.async {
            mapView.delegate = controller
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
            mapView.settings.zoomGestures = true
            mapView.settings.indoorPicker = true
            mapView.padding = UIEdgeInsets(top: 70, left: 252, bottom: 540, right: 12)
        }
    }
    
    //Set camera
    func mapCamera(
        mapView:GMSMapView,
        camera: GMSCameraPosition){
        
        CATransaction.begin()
        CATransaction.setValue(2.0, forKey: kCATransactionAnimationDuration)
        mapView.animate(to: camera)
        CATransaction.commit()
        
    }
    
    
    //Create Marker
    func createMarker(mapView:GMSMapView,titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> GMSMarker{
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = mapView
        return marker
    }
    
    
    //Open specific segue by position at ConsultationCOntroller (NoAuth)
    func segueAtConsultationControllerNoAuth(position: Int, controller: UIViewController){
        switch position {
        case 0:
            performSegue(controller: controller, identifier: K.segues.consultation.consultationControllerToOffices)
            
        case 1:
            performSegue(controller: controller, identifier: K.segues.consultation.consultationControllerToListNews)
            
        case 2:
            performSegue(controller: controller, identifier: K.segues.consultation.consultationControllerToScheduledOutages)
            
            
        case 3:
            performSegue(controller: controller, identifier: K.segues.consultation.consultationControllerToComplaints)

        case 4:
            performSegue(controller: controller, identifier: K.segues.consultation.consultationControllerToHazardReports)
            
        case 5:
            performSegue(controller: controller, identifier: K.segues.consultation.consultationControllerToInnovation)
            
        default:
            print("Empieza en 1")
        }
    }
    
    
    //Open specific segue by position at ManagementsController (NoAuth)
    func segueAtManagementsControllerNoAuth(position: Int, controller: UIViewController){
        switch position {
        case 0:
            performSegue(controller: controller, identifier: K.segues.managements.managementsControllerToBills)
        case 1:
            performSegue(controller: controller, identifier: K.segues.managements.managementsControllerToManagementsAccounts)
        case 2:
            Core.shared.performSegue(controller: controller, identifier: K.segues.managements.managementsToConsumptions)
            
        case 3:
            Core.shared.performSegue(controller: controller, identifier: K.segues.managements.managementsToCalculator)
        case 4:
            Core.shared.performSegue(controller: controller, identifier: K.segues.managements.managementsToAppointments)
        case 5:
            Core.shared.performSegue(controller: controller, identifier: K.segues.managements.managementsToNewservices)
            
        default:
            print("Empieza en 1")
        }
    }
    
    //Sharing
    func sharing(message:String, image: UIImage, controller:UIViewController) {
         
        let shareAll = [message , image] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = controller.view
        controller.present(activityViewController, animated: true, completion: nil)
    }
    
    //Call phone number
    func callPhoneNumber(phoneNumber: String, at: UIViewController) {
         if let phoneURL = NSURL(string: ("tel://" + phoneNumber)) {

                let alert = UIAlertController(title: ("LLamar: " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Llamar: ", style: .default, handler: { (action) in
                    UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
                }))

                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                at.present(alert, animated: true, completion: nil)
            }
    }
    
    //Preferences for using EasyTipView
    func preferencesEasyTipView(){
        
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: K.font.fontRegular, size: 12)!
        preferences.drawing.foregroundColor = .white
        preferences.drawing.backgroundColor = #colorLiteral(red: 0, green: 0.5372232199, blue: 0.748128593, alpha: 1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        EasyTipView.globalPreferences = preferences
    }
    
    //Validate data to Calculate
    func setCalculate(id:String, calculate:Calculate){
        if var calculateArray = Singleton.shared.getCalculatorValue(){
            var isSaved = false
            if !calculateArray.isEmpty{
                for (index, value) in calculateArray.enumerated() {
                    print("\(index): \(value)")
                    if value.id == id{
                        calculateArray[index] = calculate
                        isSaved = true
                        Singleton.shared.setCalculatorValue(data: calculateArray)
                    }
                }
                
                if !isSaved{
                    calculateArray.append(calculate)
                    Singleton.shared.setCalculatorValue(data: calculateArray)
                }
            
            }else{
                calculateArray.append(calculate)
                Singleton.shared.setCalculatorValue(data: calculateArray)
            }
        }
    }
    
    //Get Departamentos
    func departamentos() -> [String] {
        
        var array = [String]()
        
        if let departamentos = Singleton.shared.getDepartaments(){
            if !departamentos.isEmpty{
                departamentos.forEach {
                    data in
                    array.append(data.name)
                }
            }
        }
        return array
    }
    

    func municipios(departamento:String) -> [String] {
        
        var array = [String]()
        
        var selectedDepartmentID = 0
        
        if let departamentos = Singleton.shared.getDepartaments(){
            if !departamentos.isEmpty{
                departamentos.forEach {
                    data in
                    if departamento == data.name{
                        selectedDepartmentID = data.id
                    }
                }
            }
        }
        
        if let municipios = Singleton.shared.getMunicipios(), selectedDepartmentID != 0{
            if !municipios.isEmpty{
                municipios.forEach {
                    data in
                    if data.departmentID == selectedDepartmentID{
                        array.append(data.name)
                    }
                
                }
            }
        }
        
        return array
        
    }
    
    func transactions() -> [String] {
        
        var array = [String]()
        
        if let transactions = Singleton.shared.getTransactions(){
            if !transactions.isEmpty{
                transactions.forEach {
                    data in
                    array.append(data.descripcion)
                }
            }
        }
        return array
    }
    
    
    //Get documents type to be use at New Services
    func documentsNewServices() -> [String] {
        
        var array = [String]()
        
        if let documentsNewServices = Singleton.shared.getDocumentsNewServices(){
            if !documentsNewServices.isEmpty{
                documentsNewServices.forEach { data in
                    array.append(data.descripcion)
                }
            }
        }
        return array
    }
    
    //Get status type to be use at New Services
    func statusNewServices() -> [String] {
        
        var array = [String]()
        
        if let statusNewServices = Singleton.shared.getStatusNewServices(){
            if !statusNewServices.isEmpty{
                statusNewServices.forEach { data in
                    array.append(data.descripcion)
                }
            }
        }
        return array
    }
    
    
    
    //Return array reason
    func reasonsArray() -> [String]{
        var array = [String]()
        
        array.append(reasons.LineaDirecta.message.name)
        array.append(reasons.ManipulacionMedidor.message.name)
        array.append(reasons.MedidorDanado.message.name)
        array.append(reasons.MedidorSuciedadQuebrado.message.name)
        array.append(reasons.ServicioConectadoDirecto.message.name)
        array.append(reasons.SoldadorConectado.message.name)
        array.append(reasons.Otros.message.name)
        return array
    }
    
    //Return array reason hazard
    func reasonsHazardArray() -> [String]{
        var array = [String]()
        
        array.append(reasonHazard.DanioEnTransformador.message.name)
        array.append(reasonHazard.LineasEnElSuelo.message.name)
        array.append(reasonHazard.VariacionesDeVoltaje.message.name)
        array.append(reasonHazard.DaniosRetenida.message.name)
        array.append(reasonHazard.DaniosEnAcometida.message.name)
        array.append(reasonHazard.LineaRota.message.name)
        array.append(reasonHazard.PosteChocado.message.name)
        array.append(reasonHazard.ConatoDeIncendio.message.name)
        array.append(reasonHazard.LineasElectricasBajas.message.name)
        array.append(reasonHazard.LineasCortocircuitadas.message.name)
        array.append(reasonHazard.FalsoContacto.message.name)
        array.append(reasonHazard.PosteDesplomado.message.name)
        array.append(reasonHazard.PosteLavadoDeLaBase.message.name)
        array.append(reasonHazard.FallasEnAlumbradoPublico.message.name)
        return array
    }
    
    //Return array schedule
    func scheduleArray() -> [String]{
        var array = [String]()
        
        array.append(schedule.Manana.data.name)
        array.append(schedule.Tarde.data.name)
        array.append(schedule.Noche.data.name)
        array.append(schedule.Permanente.data.name)
        return array
    }
    
    //Return reason id
    func returnReason(reason:String)->String{
        switch reason {
            
        case reasons.LineaDirecta.message.name:
            return reasons.LineaDirecta.message.id.description
            
        case reasons.ManipulacionMedidor.message.name:
            return reasons.ManipulacionMedidor.message.id.description
            
        case reasons.MedidorDanado.message.name:
            return reasons.MedidorDanado.message.id.description
            
        case reasons.MedidorSuciedadQuebrado.message.name:
            return reasons.MedidorSuciedadQuebrado.message.id.description
        
        case reasons.Otros.message.name:
            return reasons.Otros.message.id.description
            
        case reasons.ServicioConectadoDirecto.message.name:
            return reasons.ServicioConectadoDirecto.message.id.description
            
        case reasons.SoldadorConectado.message.name:
            return reasons.SoldadorConectado.message.id.description
            
        default:
            return "7"
        }
    }
    
    //Return reason hazard id
    func returnReasonHazard(reason:String)->String{
        switch reason {
            
        case reasonHazard.DanioEnTransformador.message.name:
            return reasonHazard.DanioEnTransformador.message.id.description
            
        case reasonHazard.LineasEnElSuelo.message.name:
            return reasonHazard.LineasEnElSuelo.message.id.description
            
        case reasonHazard.VariacionesDeVoltaje.message.name:
            return reasonHazard.VariacionesDeVoltaje.message.id.description
            
        case reasonHazard.DaniosRetenida.message.name:
            return reasonHazard.DaniosRetenida.message.id.description
        
        case reasonHazard.DaniosEnAcometida.message.name:
            return reasonHazard.DaniosEnAcometida.message.id.description
            
        case reasonHazard.LineaRota.message.name:
            return reasonHazard.LineaRota.message.id.description
            
        case reasonHazard.PosteChocado.message.name:
            return reasonHazard.PosteChocado.message.id.description
            
        case reasonHazard.ConatoDeIncendio.message.name:
            return reasonHazard.ConatoDeIncendio.message.id.description
            
        case reasonHazard.LineasElectricasBajas.message.name:
            return reasonHazard.LineasElectricasBajas.message.id.description
            
        case reasonHazard.LineasCortocircuitadas.message.name:
            return reasonHazard.LineasCortocircuitadas.message.id.description
            
        case reasonHazard.FalsoContacto.message.name:
            return reasonHazard.FalsoContacto.message.id.description
            
        case reasonHazard.PosteDesplomado.message.name:
            return reasonHazard.PosteDesplomado.message.id.description
            
        case reasonHazard.PosteLavadoDeLaBase.message.name:
            return reasonHazard.PosteLavadoDeLaBase.message.id.description
            
        case reasonHazard.FallasEnAlumbradoPublico.message.name:
            return reasonHazard.FallasEnAlumbradoPublico.message.id.description
            
        default:
            return "14"
        }
    }
    
    //Return reason
    func returnReasonName(id:Int)->String{
        switch id {
            
        case reasons.LineaDirecta.message.id:
            return reasons.LineaDirecta.message.name
            
        case reasons.ManipulacionMedidor.message.id:
            return reasons.ManipulacionMedidor.message.name
            
        case reasons.MedidorDanado.message.id:
            return reasons.MedidorDanado.message.name
            
        case reasons.MedidorSuciedadQuebrado.message.id:
            return reasons.MedidorSuciedadQuebrado.message.name
            
        case reasons.ServicioConectadoDirecto.message.id:
            return reasons.ServicioConectadoDirecto.message.name
            
        case reasons.SoldadorConectado.message.id:
            return reasons.SoldadorConectado.message.name
            
        case reasons.Otros.message.id:
            return reasons.Otros.message.name
            
        default:
            return "No encontrado"
        }
    }
    
    
    //Return reason
    func returnReasonHazardName(id:Int)->String{
        switch id{
            
        case reasonHazard.DanioEnTransformador.message.id:
            return reasonHazard.DanioEnTransformador.message.name
           
            
        case reasonHazard.LineasEnElSuelo.message.id:
            return reasonHazard.LineasEnElSuelo.message.name
            
            
        case reasonHazard.VariacionesDeVoltaje.message.id:
            return reasonHazard.VariacionesDeVoltaje.message.name
            
        case reasonHazard.DaniosRetenida.message.id:
            return reasonHazard.DaniosRetenida.message.name
        
        case reasonHazard.DaniosEnAcometida.message.id:
            return reasonHazard.DaniosEnAcometida.message.name
            
        case reasonHazard.LineaRota.message.id:
            return reasonHazard.LineaRota.message.name
            
        case reasonHazard.PosteChocado.message.id:
            return reasonHazard.PosteChocado.message.name
            
        case reasonHazard.ConatoDeIncendio.message.id:
            return reasonHazard.ConatoDeIncendio.message.name
            
        case reasonHazard.LineasElectricasBajas.message.id:
            return reasonHazard.LineasElectricasBajas.message.name
            
        case reasonHazard.LineasCortocircuitadas.message.id:
            return reasonHazard.LineasCortocircuitadas.message.name
            
        case reasonHazard.FalsoContacto.message.id:
            return reasonHazard.FalsoContacto.message.name
            
        case reasonHazard.PosteDesplomado.message.id:
            return reasonHazard.PosteDesplomado.message.name
            
        case reasonHazard.PosteLavadoDeLaBase.message.id:
            return reasonHazard.PosteLavadoDeLaBase.message.name
            
        case reasonHazard.FallasEnAlumbradoPublico.message.id:
            return reasonHazard.FallasEnAlumbradoPublico.message.name
            
        default:
            return "No encontrado"
        }
    }
    
    
    //Return schedule
    func returnSchedule(reason:String)->String{
        switch reason {
            
        case schedule.Manana.data.name:
            return schedule.Manana.data.id.description
            
        case schedule.Tarde.data.name:
            return schedule.Tarde.data.id.description
            
        case schedule.Noche.data.name:
            return schedule.Noche.data.id.description
            
        case schedule.Permanente.data.name:
            return schedule.Permanente.data.id.description
        
            
        default:
            return "4"
        }
    }
    
    //Return schedule
    func returnScheduleName(id:Int)->String{
        switch id {
            
        case schedule.Manana.data.id:
             return schedule.Manana.data.name
            
        case schedule.Tarde.data.id:
             return schedule.Tarde.data.name
            
        case schedule.Noche.data.id:
             return schedule.Noche.data.name
            
        case schedule.Permanente.data.id:
             return schedule.Permanente.data.name
        
            
        default:
            return "No encontrado"
        }
    }
    
    
    //Return Managaments Categories
    func managamentsCategoriesArray() -> [String] {
        
        var array = [String]()
        
        array.append(managamentsCategories.Attention.data.name)
        array.append(managamentsCategories.Complaint.data.name)
        array.append(managamentsCategories.Historic.data.name)
        array.append(managamentsCategories.Supply.data.name)
        return array
    }
    
    
    
    //Disable item on tabbar
    func disableItemsOnTabbar(at:UIViewController){
        let tutorialState = Singleton.shared.checkKeyState(key: K.defaultKeys.others.tutorial)
        
        if !tutorialState{
            if  let arrayOfTabBarItems = at.tabBarController?.tabBar.items as AnyObject as? NSArray,
                let tabBarItem0 = arrayOfTabBarItems[0] as? UITabBarItem,
                let tabBarItem1 = arrayOfTabBarItems[1] as? UITabBarItem,
                let tabBarItem2 = arrayOfTabBarItems[2] as? UITabBarItem {
                
                tabBarItem0.isEnabled = false
                tabBarItem1.isEnabled = false
                tabBarItem2.isEnabled = false
            }
            
            
        }else{
            
            if  let arrayOfTabBarItems = at.tabBarController?.tabBar.items as AnyObject as? NSArray,
                let tabBarItem0 = arrayOfTabBarItems[0] as? UITabBarItem,
                let tabBarItem1 = arrayOfTabBarItems[1] as? UITabBarItem,
                let tabBarItem2 = arrayOfTabBarItems[2] as? UITabBarItem {
                
                tabBarItem0.isEnabled = true
                tabBarItem1.isEnabled = true
                tabBarItem2.isEnabled = true
            }
            
        }
    }
  
    
    //LineChart
    func lineChart(chartView:LineChartView){
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        
        chartView.backgroundColor =  #colorLiteral(red: 0.01960784314, green: 0.2549019608, blue: 0.368627451, alpha: 1)
        chartView.rightAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.labelTextColor = .clear
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.labelTextColor = .clear
        chartView.leftAxis.spaceMin = 0
        chartView.leftAxis.spaceMax = 0
        chartView.leftAxis.spaceTop = 0
        chartView.leftAxis.spaceBottom = 0
        chartView.rightAxis.spaceMin = 0
        chartView.rightAxis.spaceMax = 0
        chartView.rightAxis.spaceTop = 0
        chartView.minOffset = 0
        
        chartView.rightAxis.spaceBottom = 0
        chartView.xAxis.spaceMin = 0
        chartView.xAxis.spaceMax = 0
        chartView.autoScaleMinMaxEnabled = false
        chartView.notifyDataSetChanged()
        
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawGridLinesBehindDataEnabled = false
        chartView.leftAxis.gridColor = .clear
        chartView.leftAxis.axisLineColor = .clear
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawGridLinesBehindDataEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawGridLinesBehindDataEnabled = false
        chartView.rightAxis.gridColor = .clear
        chartView.rightAxis.axisLineColor = .clear
        chartView.legend.setCustom(entries: [])
        chartView.noDataTextColor = .white
        chartView.noDataFont = UIFont.init(name: K.font.fontRegular, size: 13) ?? UIFont.systemFont(ofSize: 12)
        chartView.noDataText = "No tenemos datos registrados"
    }
    
    
    //Setting a Bearer
    func setBearerToken(_ token: String) -> String{
        let bearer = "Bearer\(" "+token)"
        return bearer
    }
    
    
    
    //Calculate price on calculator
    func calculatePrice(kwh:Double,hours:Int) -> Double{
        return Double(kwh * Double(hours))
    }
    
    //Calculate kwh on calculator
    func calculateKwh(kwh:Double) -> Double{
        return Double(100 * kwh)
    }
    
    
    //SignOut Firebase
    func signOutFirebase(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    //Setting lottie fucntions
    func playLottie(lottie: Lotties, animationView: AnimationView, at: UIViewController){
        
        animationView.contentMode = .scaleAspectFill
        animationView.clipsToBounds = true
        
        animationView.play(fromProgress: nil, toProgress: 1, loopMode: .loop, completion: nil)
        
    }
    
    
    //Set date properly
    func reformatDate(date:String) -> String{
        let locale = Locale.init(identifier: "en_US_POSIX")
        var dateFormat = ""
        
        if let datew = Date(fromString: date, format: .httpHeader, locale: locale)
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            formatter.timeZone = .gmt
            let dateISO = datew.toISO()
            dateFormat = formatter.string(from: datew)
            
        }else{
            dateFormat = date
        }
        return dateFormat
    }
    
    //Set link at text
    func setLinkAtText(){
        
    }

    
    //MARK: - API
    //--Set event
    func event(
        code: String,
        name: String){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        var header: HTTPHeaders{
            let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.token)
            let bearer = Core.shared.setBearerToken(token)
            return
                [
                    "Authorization": bearer,
                    "Content-Type": "application/json"
            ]
        }
        
        let params: Parameters = [
            "code":code,
            "name":name,
            "platform": "ios"
        ]
        
        
        OptionsManager().event(header: header, params: params) {
            response in
            
            
            if let message = response?.message {
                
                switch message{
                case ResponseMessages.doneRegistered.message:
                    print("evento registrado")
                    break
                default:
                    print("No se registró el evento")
                }
                
            }else{
                print("No se registró el evento(Error)")
            }
            
            
        }
    }
    
    
    //--Get documents type to be use at New Services
    func getDocumentsNewServices(){
        var header: HTTPHeaders{
            return ["Content-Type": "application/json"]
        }
        
        NewServicesManager().documents(header: header) {
            response in
            guard let result = response, ((response) != nil) else{ return}
            
            if !result.data.isEmpty{
                print("documents \(response)")
                Singleton.shared.setDocumentsNewServicesArray(data: result.data)
            }
            
        }
    }
    
    //--Get status type to be use at New Services
    func getStatusNewServices(){
        var header: HTTPHeaders{
            return ["Content-Type": "application/json"]
        }
        
        NewServicesManager().status(header: header) {
            response in
            guard let result = response, ((response) != nil) else{ return}
            
            if !result.data.isEmpty{
                print("status \(response)")
                Singleton.shared.setStatusNewServicesArray(data: result.data)
            }
            
        }
    }
    
    //MARK: - XIB
    
    // Register cell at a table view
    func registerCell(at tableView: UITableView, named: String, withIdentifier: String? = nil) {
        let cellNib = UINib(nibName: named, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: withIdentifier ?? named)
    }
    
    // Register cell at a collection view
    func registerCellCollection(at collectionView: UICollectionView, named: String, withIdentifier: String? = nil) {
        let cellNib = UINib(nibName: named, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: withIdentifier ?? named)
    }
    
    
}

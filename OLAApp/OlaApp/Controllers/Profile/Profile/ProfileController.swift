//
//  ProfileController.swift
//  AESApp
//
//  Created by Alex on 6/18/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import MaterialComponents
import ETBinding
import Alamofire
import NVActivityIndicatorView
import SDWebImage
import FirebaseStorage
import TLPhotoPicker
import PhotosUI
import SwiftDate
import AFDateHelper

class ProfileController: UIViewController,NVActivityIndicatorViewable,
UIScrollViewDelegate{
    
    // MARK: - Let-Var
    var evidances = [UIImage]()
    var selectedAssets = [TLPHAsset]()
    var registerNICItems = RegisterNICItems()
    let liveDataProfile = LiveData(data: "RegisterProfileEditInfo")
    var data = [ProfileResponseData]()
    var nics = [NICSResponseData]()
    let storage = Storage.storage()
    var photo = ""
    var photoName = ""
    var names = ""
    var lastNames = ""
    var email = ""
    var selectedDate = ""
    let locale = Locale.init(identifier: "en_US_POSIX")
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
    @IBOutlet weak var bornDatelTextField: MDCOutlinedTextField!
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var phoneTextField: MDCOutlinedTextField!
    @IBOutlet weak var nicTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: RoundedImageView!
    @IBOutlet weak var bottomFloatingButton: NSLayoutConstraint!
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
        
        //Load profile
        profile()
        
    }
    
    // MARK: - Navigation
    
    
    
    // MARK: - SetUps / Funcs
    func setUpUI(){
        //Modify constraints
        Core.shared.setCustomConstraintsByDevice(constraint: bottomFloatingButton, constant: 33)
        
        
    }
    
    func setUpActions(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        //Scrollview delegate
        scrollView.delegate = weak
        
        //Tableview Delegate
        nicTableView.delegate = weak
        nicTableView.dataSource = weak
        
        //Set Cell Identifier
        Core.shared.registerCell(at: nicTableView, named: K.cellsIdentifiers.table.profileTableCell)
        
        //Setting textfield outlined
        //--Born Date textfield
        Core.shared.attributesMDCOutlinedTextField(textfield: bornDatelTextField,labelText: TextFieldText.bornDate.label, placeholder: nil)
        
        
        //--Email textfield
        Core.shared.attributesMDCOutlinedTextField(textfield: emailTextField,labelText: TextFieldText.email.label, placeholder: nil)
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        
        //--Phone textfield
        Core.shared.attributesMDCOutlinedTextField(textfield: phoneTextField,labelText: TextFieldText.phoneNumber.label, placeholder: nil)
        
        phoneTextField.keyboardType = .numberPad
        phoneTextField.textContentType = .telephoneNumber
        
        
        
        ProfileEditInfoModelData.shared.liveData.observeForever { (data) in
            
            weak var weakSelf = self
            guard let weak = weakSelf else{return}
            
            print("\(String(describing: data.name + data.lastName))")
            weak.names = data.name
            weak.lastNames = data.lastName
            
            weak.nameLabel.text = "\(data.name) \(data.lastName)"
            
            
        }
        liveDataProfile.dispatch()
        
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        bornDatelTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        datePickerView.set18YearValidation()

        
    }
    
    
    
    //Dimiss action
    @IBAction func dimissAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        dismiss(animated: true, completion: nil)
    }
    
    //Edit Profile Action
    @IBAction func editProfileAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        Core.shared.showEditProfilePopUp(controller: weak)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        
        setProfile()
    }
    
    @IBAction func selectePhotoAction(_ sender: UIButton) {
        Core.shared.buttonAnimation(sender: sender)
        showPicker()
    }
    
    func setData(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let name = weak.data.first!.names ?? ""
        let lastName = weak.data.first!.lastNames ?? ""
        Singleton.shared.setNames(name: name, lastName: lastName)
        weak.nameLabel.text = "\(name) \(lastName)"
        
    
        weak.phoneTextField.text = weak.data.first!.phoneNumber ?? ""
    
        weak.emailTextField.text = weak.data.first!.email ?? ""
        
        
        if let image = URL.init(string: weak.data.first!.picURL ?? K.defaultProfileImage){
            weak.profileImageView.sd_setImage(with: image, placeholderImage: #imageLiteral(resourceName: "pa_contacts_icon"))
        }
        
        if let birthday = weak.data.first?.birthday{
            print(birthday)
            

            if let datew = Date(fromString: birthday, format: .httpHeader, locale: locale)
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                formatter.timeZone = .gmt
                let dateISO = datew.toISO()
                print("\(formatter.string(from: datew))")
                
                bornDatelTextField.text = "\(formatter.string(from: datew))"
                
                
            }
            
        }else{
            weak.bornDatelTextField.text = ""
        }
        
        
        
    }
    
    func showPicker() {
           
           weak var weakSelf = self
           guard let weak = weakSelf else{return}
           
           selectedAssets.removeAll()
            evidances.removeAll()
        
           let viewController = TLPhotosPickerViewController()
           viewController.delegate = weak
           viewController.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
               self?.showExceededMaximumAlert(vc: picker)
           }
           var configure = TLPhotosPickerConfigure()
           configure.numberOfColumn = 3
           configure.maxSelectedAssets = 1
           configure.allowedVideo = false
           viewController.configure = configure
           viewController.selectedAssets = selectedAssets
           
           weak.present(viewController, animated: true, completion: nil)
           
       }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0)
         {
            bottomFloatingButton.constant = 134.0
         }
        else
        {
            bottomFloatingButton.constant = 33.0
        }
    }
    
    //--Load Scheduled Outages
    func profile(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        //weak.customLoading()
        
        if !data.isEmpty{
            weak.data.removeAll()
        }
        
       
        
        UserManager().profile(header: header) {
            response in
            
            
            guard let responseScheduledOutages = response, ((response?.data) != nil) else{
                weak.stopAnimating()
                return
            }
            
            switch responseScheduledOutages.message{
            case ResponseMessages.success.message:
                weak.stopAnimating()
                if let response =  response?.data, !response.isEmpty{
                    
                    weak.data = response
                    weak.setData()
                    
                }
                
                break
                
            default:
                
                weak.stopAnimating()
                return
            }
            
        }
        
    }
    
    
    //--Load Scheduled Outages
    func loadNics(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        weak.customLoading()
        if !nics.isEmpty{
            weak.nics.removeAll()
        }
        
        
        
        UserManager().getNic(header: header) {
            response in
            
            
            guard let responseScheduledOutages = response, ((response?.data) != nil) else{
                weak.stopAnimating()
                return
            }
            
            switch responseScheduledOutages.message{
            case ResponseMessages.success.message:
                weak.stopAnimating()
                if let data =  response?.data{
                    if !data.isEmpty{
                        weak.nics = data
                        weak.nicTableView.reloadData()
                    }
                    
                }else{
                    weak.stopAnimating()
                }
                
                break
                
            default:
                
                weak.stopAnimating()
                return
            }
            
        }
    }
    
    
    //Starge firebase
    func setPhotos(withImage: UIImage) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        if photoName == ""{
            weak.photoName = Singleton.shared.checkPushToken()
        }
        
        guard let imageData = withImage.jpegData(compressionQuality: 0.5) else { return }
        let storageRef = Storage.storage().reference()
        
        let thisUserPhotoStorageRef = storageRef.child("user_pictures").child("\(photoName).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        thisUserPhotoStorageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                Core.shared.alert(message: "Una o más fotografías no pudieron ser cargadas", title: K.titles.alertWrongTitle, at: weak)
                return
            }

            thisUserPhotoStorageRef.downloadURL { (url, error) in
                print(metadata.size) // Metadata contains file metadata such as size, content-type.
                thisUserPhotoStorageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                    
                    weak.photo = downloadURL.description
                    print(downloadURL)

                }
            }
        }
    }
    
    
    
    //--Set report
    func setProfile(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let params: Parameters = [
        "pic_url": photo,
        "names": names,
        "last_names": lastNames,
        "email": emailTextField.text ?? "",
        "phone_number": phoneTextField.text ?? "",
        "birthday": bornDatelTextField.text  ?? "",
        "push_tok": Singleton.shared.checkPushToken()]
        
        
        UserManager().updateProfile(header: header, params: params) {
            response in
            
            
            guard let message = response?.message else{return}
            
            switch message{
            case ResponseMessages.updated.message:
                
                Core.shared.alert(message: "OK", title: "El perfile se actualizó", at: weak)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    weak.dismiss(animated: true, completion: nil)
                }
                break
                
                
            default:
                return
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
    
    
    
   
    // MARK: - Objective C
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        bornDatelTextField.text = dateFormatter.string(from: sender.date)
        
    }

}




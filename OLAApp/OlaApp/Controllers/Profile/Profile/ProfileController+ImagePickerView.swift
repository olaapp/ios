//
//  ProfileController+ImagePickerView.swift
//  AESApp
//
//  Created by Alex on 7/11/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit
import PhotosUI
import TLPhotoPicker

extension ProfileController:TLPhotosPickerViewControllerDelegate{
    // MARK: - TLPIckerActions
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        // use selected order, fullresolution image
        selectedAssets = withTLPHAssets
        
        let imageManager = PHCachingImageManager()
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.isSynchronous = true
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        let targetSize = CGSize(width:770, height: 820)
        
        let assets = withTLPHAssets.compactMap({ $0.phAsset })
        for asset in assets {

            
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFit, options: options) { (receivedImage, info) in
                
                guard let image = receivedImage else { return }
                weak.evidances.append(image)
                weak.photoName = weak.selectedAssets.first!.originalFileName ?? Singleton.shared.checkPushToken()
                weak.evidances.forEach { resultPhoto in
                    weak.setPhotos(withImage: resultPhoto)
                    weak.profileImageView.image = resultPhoto
                }
                
            }
        }
        
      
    }
    
    
    func showExceededMaximumAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "", message: "Solo puedes seleccionar 5 fotografías", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    func photoPickerDidCancel() {
        self.navigationController?.dismiss(animated: true) {}
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        self.showExceededMaximumAlert(vc: picker)
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        picker.dismiss(animated: true) {
            let alert = UIAlertController(title: "", message: "Denied albums permissions granted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        let alert = UIAlertController(title: "", message: "Denied camera permissions granted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        picker.present(alert, animated: true, completion: nil)
    }
    
}



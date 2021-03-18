//
//  MainTabBarController.swift
//  AESApp
//
//  Created by Alex on 5/3/20.
//  Copyright © 2020 AES. All rights reserved.
//

import UIKit
import Spring
import EasyTipView
import MaterialComponents


class MainTabBarController:  UITabBarController,UITabBarControllerDelegate {
    
    // MARK: - Let-Var
    let button = SpringButton.init(type: .custom)
    var firstTabbarItemImageView: UIImageView!
    var secondTabbarItemImageView: UIImageView!
    
    // MARK: - Outlets
    @IBOutlet weak var bottomtabBar: UITabBar!
    
    override func viewDidLoad() {
        delegate = self
        
        
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 0.6941176471, alpha: 1)
        
        // setting up general actions/delegates/Core
        setUpActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Core.shared.posisitonAtMiddleButton(view: self.view, button: button, tabBar: tabBar)
        
    }
    
    
    func setUpActions() {
        
        
        //Set middle Button
        Core.shared.setMiddleButtonTabBar(view: view, button: button, tabBar: tabBar)
        
        //Setting our controllers by instances on Storyboards in order to set them
        
        let first =  Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: K.storyboards.consultation), identifier: K.instances.consultationController)
        
        let second =
            Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: K.storyboards.managements), identifier: K.instances.managementsController)
        
//        let second =
//        Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: "NewServices"), identifier: "NewServicesController")
        
       
        
        let middle =  Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: K.storyboards.chat), identifier: K.instances.chatController)
        
        
        
        //configure the view controllers here...
        viewControllers = [first,middle ,second]
        
        //Items
        setItems()
        
        //EasyTipView
        Core.shared.preferencesEasyTipView()
        
        //Subviews to be animated
        let firstItemView = tabBar.subviews.first!
        firstTabbarItemImageView = firstItemView.subviews.first as? UIImageView
        firstTabbarItemImageView.contentMode = .center

        let secondItemView = self.tabBar.subviews[1]
        self.secondTabbarItemImageView = secondItemView.subviews.first as? UIImageView
        self.secondTabbarItemImageView.contentMode = .center
        
        
    }
    
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
    
    
    //Set Items
    func setItems() {
        Core.shared.customItemTabbar(tabBar: tabBar, position: 0, image: #imageLiteral(resourceName: "button_a"), edgeInsets: UIEdgeInsets(top: -8, left: 0, bottom: 0, right: -60))
        
        Core.shared.customItemTabbar(tabBar: tabBar, position: 2, image: #imageLiteral(resourceName: "button_b"), edgeInsets: UIEdgeInsets(top: -8, left: -60, bottom: 0, right: 0))
        
        
        //Middle Item
        tabBar.items?[1].title = " "
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
         if tabBarIndex == 1 {
            
            let tipView = EasyTipView(text: K.storyboards.chat)
            tipView.show(forItem: (tabBar.items?[1])!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                tipView.dismiss()
            }
            button.animation = "squeeze"
            button.animate()
            
         }
        
        if tabBarIndex == 0 {
            animate(firstTabbarItemImageView)
        }
        
        if tabBarIndex == 2 {
            animate(secondTabbarItemImageView)
        }
        
        
    }

   
    
    
    
    
    
}

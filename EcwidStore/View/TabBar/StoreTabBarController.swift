//
//  StoreTabBarController.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class StoreTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
        self.delegate = self
        viewControllers = [createHomeNC() , createCategoriesNC(),createFavoritesNC()]
    }
    
    
    func createHomeNC() -> UINavigationController{
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SF_house_fill"), tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createCategoriesNC() -> UINavigationController {
        let categoriesVC = CategoriesVC()
        categoriesVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SF_cart_fill"), tag: 1)
        return UINavigationController(rootViewController: categoriesVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let signupVC = ProfileVC()
        signupVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "SF_person_icloud_fill"), tag: 2)
        return UINavigationController(rootViewController: signupVC)
    }
    
}
extension StoreTabBarController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let rootViewController = viewController as? UINavigationController else{return true}
        if let userFound = UserDefaults.standard.value(forKey: "verifyID") {
            print("user is found\(userFound)")
        } else {
            print("user not found")
            if (rootViewController.visibleViewController?.isKind(of: ProfileVC.self))! {
                let signupVC = SignupVC()
                let nc = UINavigationController(rootViewController: signupVC)
                nc.navigationBar.isHidden = true
                tabBarController.present(nc,animated: true)
                return false
            }
        }
     
        return true
    }
    
}

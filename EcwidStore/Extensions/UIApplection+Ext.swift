//
//  UIApplection+Ext.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
    {
        if let nav = base as? UINavigationController
        {
            let top = topViewController(nav.visibleViewController)
            return top
        }
        
        if let tab = base as? UITabBarController
        {
            if let selected = tab.selectedViewController
            {
                let top = topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController
        {
            let top = topViewController(presented)
            return top
        }
        return base
    }
}

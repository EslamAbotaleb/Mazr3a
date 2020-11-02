//
//  DataLoadingVC.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class DataLoadingVC: UIViewController {
    
    var containerView:UIView!

    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .white
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.15) {
            self.containerView.alpha = 0.8
        }
        
        let activivtyIndicator = UIActivityIndicatorView(style: .gray)
        containerView.addSubview(activivtyIndicator)
        
        activivtyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activivtyIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activivtyIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activivtyIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}

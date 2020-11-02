//
//  UITableView+Ext.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

extension UITableView{
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}

extension UICollectionView {
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

extension UIPickerView {
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadAllComponents()
        }
    }
}

//
//  UIHelper.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

enum UIHelper {
    
    static func getCategoriesFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
        
        let padding:CGFloat = 2
        let minimumItemSpacing:CGFloat = 4
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.itemSize = CGSize(width: 80, height: 110)
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
    
    
    static func getCategoryDetailsFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
           let padding:CGFloat = 2
           let minimumItemSpacing:CGFloat = 2
           
           let flowLayout = UICollectionViewFlowLayout()
           flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
           flowLayout.minimumInteritemSpacing = minimumItemSpacing
           flowLayout.itemSize = CGSize(width: 150, height: 180)
           flowLayout.scrollDirection = .horizontal
           return flowLayout
       }
    
    static func getCategoryCartFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
           let padding:CGFloat = 2
           let minimumItemSpacing:CGFloat = 2
             let width = view.bounds.width
            let availableWidth = width - (padding * 2) - (minimumItemSpacing * 1)
            let cellWidth = availableWidth
           let flowLayout = UICollectionViewFlowLayout()
           flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
           flowLayout.minimumInteritemSpacing = minimumItemSpacing
           flowLayout.itemSize = CGSize(width: cellWidth, height: 100)
           flowLayout.scrollDirection = .vertical
           return flowLayout
       }
    
    
    static func getTwoCellsFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
           let width = view.bounds.width
           let padding:CGFloat = 16
           let minimumItemSpacing:CGFloat = 16
           let availableWidth = width - (padding * 2) - (minimumItemSpacing * 1)
           let cellWidth = availableWidth / 2
           
           let flowLayout = UICollectionViewFlowLayout()
           flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
           flowLayout.minimumInteritemSpacing = minimumItemSpacing
           flowLayout.scrollDirection = .vertical
           flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 150)
           
           return flowLayout
       }
    static func getOneCellsFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
           let width = view.bounds.width
           let padding:CGFloat = 16
           let minimumItemSpacing:CGFloat = 16
           let availableWidth = width
           let cellWidth = availableWidth 
           
           let flowLayout = UICollectionViewFlowLayout()
           flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
           flowLayout.minimumInteritemSpacing = minimumItemSpacing
           flowLayout.scrollDirection = .vertical
           flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 150)
           
           return flowLayout
       }
}

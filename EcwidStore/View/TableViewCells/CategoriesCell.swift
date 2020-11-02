//
//  CategoriesCell.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit


class CategoriesCell: UITableViewCell {
    
    static let reuseID = "CategoriesCell"
    
    var CategoriesCollectionView:UICollectionView!
    
    
    var items = [Item](){
        didSet {
            self.CategoriesCollectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCollectionView()
        print("this is inside categories cell \(items)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView(){
        CategoriesCollectionView = UICollectionView(frame: bounds, collectionViewLayout: UIHelper.getCategoriesFlowLayout(in: self))
        addSubview(CategoriesCollectionView)
        CategoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        CategoriesCollectionView.delegate = self
        CategoriesCollectionView.dataSource = self
        CategoriesCollectionView.backgroundColor = .white
        CategoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        CategoriesCollectionView.allowsSelection = true
        CategoriesCollectionView.showsHorizontalScrollIndicator = false
        CategoriesCollectionView.allowsSelection = true
        
        NSLayoutConstraint.activate([
            CategoriesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            CategoriesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            CategoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            CategoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
        ])
    }
    
}
extension CategoriesCell: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as! CategoryCell
        cell.setup(with: self.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoryProductsVC()
        let categoryID = self.items[indexPath.item].id
        StoreClient.shared.getFullCategory(for: categoryID) { (result) in
            switch result {
            case.failure(let error):
                print(error)
            case .success(let category):
                let ids = category.productIDS
                vc.productsIDs = ids
                vc.category = category
                DispatchQueue.main.async {
                    let nc = UINavigationController(rootViewController: vc)
                    guard let rootViewController = UIApplication.topViewController() else{return}
                    rootViewController.present(nc, animated: true)
                }
                
            }
        }
    }
    
    
}

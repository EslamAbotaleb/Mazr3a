//
//  CategoryDetailsCell.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class CategoryDetailsCell: UITableViewCell {
    
    static let reuseID = "CategoryDetailsCell"
    
    let titleLabel = UILabel()
    let moreButton = UIButton()
    var collectionView:UICollectionView!
    var storeCategoryItem:Item!
    
    var category:StoreCategory?
    
    var items = [PItem]()
    var productIDs = [Int]()
    
        override func awakeFromNib() {
            super.awakeFromNib()
            self.items.removeAll()
            self.collectionView.reloadDataOnMainThread()
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCollectionView()
        setTitleLabel()
        setMoreButton()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with item: Item){
        self.items.removeAll()
        self.collectionView.reloadDataOnMainThread()
        self.titleLabel.text = item.name
        StoreClient.shared.getFullCategory(for: item.id) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let category):
                self.category = category
                self.productIDs = category.productIDS
                self.items.removeAll()
                self.collectionView.reloadDataOnMainThread()
                StoreClient.shared.getSubCategory(for: category.productIDS) { (result) in
                    switch result{
                    case.failure(let error):
                        print(error)
                    case .success(let subCategory):
                        for item in subCategory.items {
                            if item.enabled {
                                self.items.append(item)
                            }
                        }
                        self.collectionView.reloadDataOnMainThread()
                    }
                }
            }
        }
    }
    
    private func setTitleLabel(){
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.text = "Fresh balady meat لحم فريش بلدي"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setMoreButton(){
        moreButton.setImage(UIImage(named: "SF_chevron"), for: .normal)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.addTarget(self, action: #selector(HandleMoreButtonTab), for: .touchUpInside)
    }
    
    
    @objc func HandleMoreButtonTab(){
        let vc = CategoryProductsVC()
        vc.productsIDs = self.productIDs
        vc.category = self.category
        let nc = UINavigationController(rootViewController: vc)
        guard let rootVC = self.window?.rootViewController else {return}
        rootVC.present(nc,animated: true)
    }
    
    private func setCollectionView(){
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: UIHelper.getCategoryDetailsFlowLayout(in: self))
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func layoutUI(){
        addSubViews(titleLabel,moreButton,collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            moreButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            moreButton.heightAnchor.constraint(equalToConstant: 20),
            moreButton.widthAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
extension CategoryDetailsCell: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let  productCell = cell as? ProductCell {
            if indexPath.row < items.count {
                productCell.set(with: items[indexPath.row])
            }else {
                self.collectionView.reloadDataOnMainThread()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SingleProductVC()
        vc.modalPresentationStyle = .currentContext
        vc.item = self.items[indexPath.item]
        guard let rootVC = UIApplication.topViewController() else {return}
        rootVC.definesPresentationContext = true
        rootVC.present(vc, animated: true, completion: nil)
    }
}

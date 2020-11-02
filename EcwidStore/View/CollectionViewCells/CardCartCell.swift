//
//  CardCartCell.swift
//  EcwidStore
//
//  Created by Islam Abotaleb on 10/30/20.
//  Copyright © 2020 zeyad. All rights reserved.
//

import UIKit
class CardCartCell: UICollectionViewCell {
    static let reuseID = "cardCartCell"
    
    let productImageViewInCart = UIImageView(image: UIImage(named: "Food"))
    let titleProductlabel = UILabel()
    let priceProductlabel = UILabel()
    var totalPriceDOuble = 0.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- set product in cart
    func set(with product: CartModel) {
        self.productImageViewInCart.downloadImage(fromURL: product.imageURL)
        self.titleProductlabel.text = product.name
        self.priceProductlabel.text = product.defaultDisplayedPriceFormatted
       
    }
    
    //MARK:- configuration items
    private func configure() {
        productImageViewInCart.contentMode = .scaleAspectFill
        productImageViewInCart.translatesAutoresizingMaskIntoConstraints = false
        productImageViewInCart.clipsToBounds = true
        
        titleProductlabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleProductlabel.textColor = .black
        titleProductlabel.textAlignment = .justified
        titleProductlabel.numberOfLines = 2
        titleProductlabel.translatesAutoresizingMaskIntoConstraints = false
        priceProductlabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        priceProductlabel.textAlignment = .left
        priceProductlabel.numberOfLines = 1
        priceProductlabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK:- layout user interface
    private func layoutUI() {
        addSubViews(productImageViewInCart, titleProductlabel, priceProductlabel)
        NSLayoutConstraint.activate([
            //Image Product
            productImageViewInCart.topAnchor.constraint(equalTo: topAnchor),
            productImageViewInCart.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            productImageViewInCart.heightAnchor.constraint(equalToConstant: 100.0),
            productImageViewInCart.widthAnchor.constraint(equalToConstant: 100.0),
            productImageViewInCart.trailingAnchor.constraint(equalTo: self.titleProductlabel.leadingAnchor, constant: -5.0),
            
            //Title Product
            titleProductlabel.topAnchor.constraint(equalTo: topAnchor, constant: 15.0),
            titleProductlabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            titleProductlabel.heightAnchor.constraint(equalToConstant: 30),
            titleProductlabel.bottomAnchor.constraint(equalTo: self.priceProductlabel.topAnchor, constant: 10.0),
            
            //Price Product
            priceProductlabel.leadingAnchor.constraint(equalTo: self.productImageViewInCart.trailingAnchor, constant: 5.0),
            priceProductlabel.heightAnchor.constraint(equalToConstant: 30.0),
            priceProductlabel.widthAnchor.constraint(equalToConstant: 150.0),
            
        ])
    }
}

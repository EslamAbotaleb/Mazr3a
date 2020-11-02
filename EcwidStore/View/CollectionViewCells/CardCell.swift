//
//  CardCell.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    static let reuseID = "CardCell"
    
    let productImageView = UIImageView(image: UIImage(named: "Food"))
    let discriptionLabel = UILabel()
    let priceLabel = UILabel()
    let addToCardButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with item:PItem){
        self.productImageView.downloadImage(fromURL: item.imageURL ?? "")
        self.discriptionLabel.text = Helpers.handleDescriptionString(description: item.itemDescription ?? "")
        self.priceLabel.text = item.defaultDisplayedPriceFormatted
        configureAddButton(for: item.inStock ?? false)
    }
    
    private func configure(){
        productImageView.contentMode = .scaleAspectFill
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.clipsToBounds = true
        
        discriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        discriptionLabel.textColor = .gray
        discriptionLabel.textAlignment = .center
        discriptionLabel.numberOfLines = 2
        discriptionLabel.text = "Dairy Products منتجات البانDairy Products منتجات البان"
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .center
        priceLabel.numberOfLines = 1
        priceLabel.text = "EGP 28.00"
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addToCardButton.setTitle("add to Cart اضف الي السله", for: .normal)
        addToCardButton.titleLabel?.numberOfLines = 2
        addToCardButton.titleLabel?.textAlignment = .center
        addToCardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        addToCardButton.setTitleColor(.black, for: .normal)
        addToCardButton.backgroundColor = .white
        addToCardButton.layer.borderWidth = 1
        addToCardButton.layer.borderColor = UIColor.lightGray.cgColor
        addToCardButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureAddButton(for inStock:Bool){
        if inStock {
            addToCardButton.setTitle("add to Cart اضف الي السله", for: .normal)
            addToCardButton.titleLabel?.numberOfLines = 2
            addToCardButton.titleLabel?.textAlignment = .center
            addToCardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            addToCardButton.setTitleColor(.black, for: .normal)
            addToCardButton.backgroundColor = .white
            addToCardButton.layer.borderWidth = 1
            addToCardButton.layer.borderColor = UIColor.lightGray.cgColor
            addToCardButton.translatesAutoresizingMaskIntoConstraints = false
        }else {
            self.addToCardButton.setTitle("Out of stock", for: .normal)
            self.addToCardButton.layer.borderWidth = 0
            self.addToCardButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    
    func layoutUI(){
        addSubViews(productImageView,discriptionLabel,priceLabel,addToCardButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: widthAnchor),

            discriptionLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 2),
            discriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            discriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            discriptionLabel.heightAnchor.constraint(equalToConstant: 40),
            
            priceLabel.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            addToCardButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0),
            addToCardButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            addToCardButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addToCardButton.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: -12),
        ])
    }
    
}

//
//  ProductCell.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let reuseID = "ProductCell"
    
    let produceImageView = UIImageView()
    let detailsView = UIView()
    let mainTitleLabel = UILabel()
    let subtitleLabel = UILabel()
    let priceLabel = UILabel()
    let amountLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellView()
        configureProductImage()
        configureLabels()
        configureDetailsView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with item:PItem){
        self.produceImageView.downloadImage(fromURL: item.imageURL ?? "")
        self.mainTitleLabel.text = item.name ?? "Name"
        self.subtitleLabel.text = Helpers.handleDescriptionString(description: item.itemDescription ?? "")
        self.priceLabel.text = "\(item.defaultDisplayedPriceFormatted ?? "no")"
        self.amountLabel.text = "\(item.weight ?? 0 )K"
    }
     override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) { // for animation effect
                     self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { // for animation effect
                     self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
            }
        }
    }
    
    private func configureCellView(){
        backgroundColor = .white
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
    }
    
    private func configureProductImage(){
        produceImageView.image = UIImage(named: "Food")
        produceImageView.contentMode = .scaleToFill
        produceImageView.clipsToBounds = true
        produceImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureDetailsView(){
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.addSubViews(mainTitleLabel,subtitleLabel,priceLabel,amountLabel)
        
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 10),
            mainTitleLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 15),
            mainTitleLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -20),
            mainTitleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            subtitleLabel.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 15),
            subtitleLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -20),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 12),
            
            priceLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -20),
            priceLabel.heightAnchor.constraint(equalToConstant: 12),
            
            amountLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20),
            amountLabel.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -20),
            amountLabel.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    private func configureLabels(){
        mainTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        mainTitleLabel.textColor = .black
        mainTitleLabel.textAlignment = .left
        mainTitleLabel.text = "Balady"
        mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .left
        subtitleLabel.text = "Fresh..."
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        priceLabel.textColor = .green
        priceLabel.textAlignment = .left
        priceLabel.text = "90"
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        amountLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        amountLabel.textColor = .black
        amountLabel.textAlignment = .center
        amountLabel.text = "0.5k"
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutUI(){
        addSubViews(produceImageView,detailsView)
        NSLayoutConstraint.activate([
            produceImageView.topAnchor.constraint(equalTo: topAnchor),
            produceImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            produceImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            produceImageView.heightAnchor.constraint(equalToConstant: 90),
            
            detailsView.topAnchor.constraint(equalTo: produceImageView.bottomAnchor),
            detailsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

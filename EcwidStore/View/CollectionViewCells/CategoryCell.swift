//
//  CategoryCell.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let reuseID = "CategoryCell"
    
    let categoryImageView = UIImageView()
    let categoryTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureCellView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setup(with item: Item){
        self.categoryImageView.downloadImage(fromURL: item.originalImageURL)
        self.categoryTitleLabel.text = item.name
    }
    
    
    private func configureCellView(){
        backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.2
    }
    
    private func configure(){
        categoryImageView.image = UIImage(named: "FA_Buffer")
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.clipsToBounds = true
        
        categoryTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        categoryTitleLabel.textColor = .black
        categoryTitleLabel.textAlignment = .center
        categoryTitleLabel.text = "Fresh balad"
        
        addSubview(categoryImageView)
        addSubview(categoryTitleLabel)
        
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            categoryImageView.heightAnchor.constraint(equalToConstant: 60),
            
            categoryTitleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 0),
            categoryTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            categoryTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),

        ])
    }
}

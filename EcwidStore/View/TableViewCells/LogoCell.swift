//
//  LogoCell.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class LogoCell: UITableViewCell {

    static let reuseID = "CategoriesCell"
    
    let logoImageView = UIImageView(image: UIImage(named: "Mazra3a"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let padding = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        bounds = bounds.inset(by: padding)
    }
    
    private func configure(){
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFill
        clipsToBounds = true
        
        let offset:CGFloat = 25

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor , constant: offset),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: offset),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -offset),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -offset),
        ])
    }
    
}

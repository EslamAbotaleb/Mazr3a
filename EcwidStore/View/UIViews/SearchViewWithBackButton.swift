//
//  SearchViewWithBackButton.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class SearchViewWithBackButton: UIView {

    let backButton = UIButton()
    let searchbar = UISearchBar()
    let cardButton = MIBadgeButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "SF_arrow"), for: .normal)
        backgroundColor = .white
        cardButton.setImage(UIImage(named: "SF_cart_badge_plus_fill"), for: .normal)
        cardButton.translatesAutoresizingMaskIntoConstraints = false
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.placeholder = "Search"
        searchbar.searchBarStyle = .minimal
    }
    
    func layoutUI(){
        addSubViews(backButton,searchbar,cardButton)
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            backButton.trailingAnchor.constraint(equalTo: searchbar.leadingAnchor, constant: -8),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            
            searchbar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchbar.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 8),
            searchbar.trailingAnchor.constraint(equalTo: cardButton.leadingAnchor, constant: -8),
            searchbar.heightAnchor.constraint(equalToConstant: 35),

            cardButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cardButton.widthAnchor.constraint(equalToConstant: 25),
            cardButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}

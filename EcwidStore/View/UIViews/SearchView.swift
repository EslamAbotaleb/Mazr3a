//
//  SearchView.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

class SearchView: UIView {

    let cityLabel = UILabel()
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
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cityLabel.textColor = #colorLiteral(red: 0.2274509804, green: 0.5058823529, blue: 0.1137254902, alpha: 1)
        cityLabel.textAlignment = .left
        cityLabel.text = "City"
        
        cardButton.setImage(UIImage(named: "SF_cart_badge_plus_fill"), for: .normal)
        cardButton.translatesAutoresizingMaskIntoConstraints = false
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.placeholder = "Search"
        searchbar.searchBarStyle = .minimal
    }
    
    func layoutUI(){
        addSubViews(cityLabel,searchbar,cardButton)
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cityLabel.trailingAnchor.constraint(equalTo: searchbar.leadingAnchor, constant: -8),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            
            searchbar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchbar.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 8),
            searchbar.trailingAnchor.constraint(equalTo: cardButton.leadingAnchor, constant: -8),
            searchbar.heightAnchor.constraint(equalToConstant: 35),

            cardButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cardButton.widthAnchor.constraint(equalToConstant: 25),
            cardButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

}

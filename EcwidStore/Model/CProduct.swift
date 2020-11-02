//
//  Product.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//


import Foundation

// MARK: - CProducts
struct CProduct: Codable {
    let total, count, offset, limit: Int
    let items: [PItem]
}

// MARK: - Item
struct PItem: Codable {
    let id: Int
    let name: String?
    let defaultDisplayedPriceFormatted: String?
    let weight: Double?
    let enabled: Bool
    let itemDescription: String?
    let imageURL:String?
    let inStock: Bool?
    let discountsAllowed: Bool?
 
    enum CodingKeys: String, CodingKey {
        case id
        case name,defaultDisplayedPriceFormatted,weight,inStock,discountsAllowed
        case enabled
        case itemDescription = "description"
        case imageURL = "imageUrl"
    }
}

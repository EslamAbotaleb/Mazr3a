//
//  Category.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import Foundation

// MARK: - Categroy
struct StoreCategory: Codable {
    let id, orderBy: Int
    let parentID: Int?
    let hdThumbnailURL, thumbnailURL, originalImageURL: String
    let imageURL: String?
    let originalImage, thumbnail: OriginalImage
    let borderInfo: BorderInfo
    let name: String
    let url: String
    let productCount, enabledProductCount: Int
    let welcomeDescription: String
    let enabled: Bool
    let productIDS: [Int]
    let isSampleCategory: Bool

    
    
    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parentId"
        case orderBy
        case hdThumbnailURL = "hdThumbnailUrl"
        case thumbnailURL = "thumbnailUrl"
        case originalImageURL = "originalImageUrl"
        case imageURL = "imageUrl"
        case originalImage, thumbnail, borderInfo, name, url, productCount, enabledProductCount
        case welcomeDescription = "description"
        case enabled
        case productIDS = "productIds"
        case isSampleCategory
    }
}


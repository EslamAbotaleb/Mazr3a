//
//  Categories.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import Foundation

// MARK: - Categories
struct StoreCategories: Codable {
    let total, count, offset, limit: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let parentID: Int?
    let orderBy: Int
    let hdThumbnailURL, thumbnailURL, originalImageURL: String
    let imageURL: String?
    let originalImage, thumbnail: OriginalImage
    let borderInfo: BorderInfo
    let name: String
    let url: String
    let productCount: Int
    let itemDescription: String
    let enabled, isSampleCategory: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parentId"
        case orderBy
        case hdThumbnailURL = "hdThumbnailUrl"
        case thumbnailURL = "thumbnailUrl"
        case originalImageURL = "originalImageUrl"
        case imageURL = "imageUrl"
        case originalImage, thumbnail, borderInfo, name, url, productCount
        case itemDescription = "description"
        case enabled, isSampleCategory
    }
}

// MARK: - BorderInfo
struct BorderInfo: Codable {
    let dominatingColor: DominatingColor
    let homogeneity: Bool
}

// MARK: - DominatingColor
struct DominatingColor: Codable {
    let red, green, blue, alpha: Int
}

// MARK: - OriginalImage
struct OriginalImage: Codable {
    let url: String
    let width, height: Int
}


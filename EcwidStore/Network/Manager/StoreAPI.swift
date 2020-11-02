//
//  StoreAPI.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import Foundation

let token = "public_eVEGR9tWeKfbbjsc4DpNe9Cx5JcBBGk6"
// new token
//public_eVEGR9tWeKfbbjsc4DpNe9Cx5JcBBGk6
//old token
//public_jBZChCPsjLifAmCKG6h56J42CabUcm9L
public enum StoreAPI {
    
    
    //MARK:- ROOM APIs
    
    case categories(offset:Int)
    case getCategory(forId:Int)
    case getSubCategory(productsIDS:[Int])
    case getProductsBySort(sortBy: String)

}

//MARK:- ROOM ENDPOINTs

extension StoreAPI: EndPointType {
    
    // Base URL Constructor
    var environmentBaseURL : String {
        return "https://app.ecwid.com/api/v3/13995032/"
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
        
    }
    
    // URL Paths
    
    var path: String {
        switch self {
        case .categories:
            return "categories"
        case .getCategory(let id):
            return "categories/\(id)"
        case .getSubCategory:
            return "products"
        case .getProductsBySort:
            return "products"
        }
    }
    
   
    //MARK:- BODY PARAMETERS
    
    var bodyParameters: [String:Any]?{
        switch self {
        case .categories , .getCategory , .getSubCategory, .getProductsBySort:
            return nil
        }
    }
    
    //MARK: URL PARAMETERS
    var urlParameters: Parameters?{
        switch self {
        case .categories(let offset):
            var parameter: Parameters = [String : Any]()
            parameter["token"] = token
            parameter["limit"] = "10"
            parameter["offset"] = "\(offset)"
            return parameter
        case .getCategory(_):
            var parameter: Parameters = [String : Any]()
            parameter["token"] = token
            return parameter
        case .getSubCategory(let productsIDS):
            var parameter: Parameters = [String : Any]()
            parameter["token"] = token
            let first10 = productsIDS.prefix(10)
            let formattedArray = (first10.map{String($0)}).joined(separator: ",")
            parameter["productId"] = formattedArray
            return parameter
        case .getProductsBySort(let sortBy):
            var parameter: Parameters = [String : Any]()
            parameter["token"] = token
            parameter["sortBy"] = sortBy
            return parameter
        }
    }
    
    //MARK:- CONFIGURE REQUESTS
    var httpMethod: HTTPMethod {
             return .get
         }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var task: HTTPTask {
        switch self {            
        case .categories , .getCategory , .getSubCategory, .getProductsBySort:
            return .requestParameters(bodyParameters: bodyParameters, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
//        default:
//            return .requestParameters(bodyParameters: bodyParameters, bodyEncoding: .urlEncoding, urlParameters: urlParameters)
        }
    }
    
}

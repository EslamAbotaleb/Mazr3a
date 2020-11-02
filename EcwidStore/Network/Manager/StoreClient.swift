//
//  StoreClient.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit


class StoreClient {
    
    static let shared = StoreClient()
    private let router = Router<StoreAPI>()
    let cache = NSCache<NSString,UIImage>()
    
    func getCategories(offset:Int, completion: @escaping (Result<StoreCategories,StoreError>) -> Void){
        router.request(.categories(offset:offset)) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.connectionError))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidDate))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let categories = try decoder.decode(StoreCategories.self, from: data)
                completion(.success(categories))
            }
            catch{
                completion(.failure(.decodeError))
            }
        }
    }
    
    func getProductBySorting(sortBy:String, completion: @escaping (Result<CProduct,StoreError>) -> Void){
        router.request(.getProductsBySort(sortBy: sortBy)) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.connectionError))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidDate))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let products = try decoder.decode(CProduct.self, from: data)
                completion(.success(products))
            }
            catch{
                completion(.failure(.decodeError))
            }
        }
    }
    
    
    
    func getFullCategory(for id: Int , completion: @escaping (Result<StoreCategory,StoreError>) -> Void){
        router.request(.getCategory(forId: id)) { (data, response, error) in
            if error != nil {
                completion(.failure(.connectionError))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidDate))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let category = try decoder.decode(StoreCategory.self, from: data)
                completion(.success(category))
            }
            catch{
                completion(.failure(.decodeError))
            }
        }
    }
    
    func getSubCategory(for producetIDs:[Int] , completion: @escaping (Result<CProduct,StoreError>) -> Void){
        router.request(.getSubCategory(productsIDS: producetIDs)) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.connectionError))
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidDate))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let subCategory = try decoder.decode(CProduct.self, from: data)
                completion(.success(subCategory))
            }
            catch{
                completion(.failure(.decodeError))
            }
            
        }
    }
    
    
    
    func downloadImage(from stringURL:String , completed: @escaping (UIImage?) -> Void) {
        let imageKey = NSString(string: stringURL)
        
        if let image = cache.object(forKey: imageKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: stringURL) else {
            completed(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self ,
                error == nil ,
                let response = response as? HTTPURLResponse ,
                response.statusCode == 200 ,
                let data = data ,
                let image = UIImage(data: data)
                else {
                    
                    completed(nil)
                    return
            }
            self.cache.setObject(image, forKey: imageKey)
            completed(image)
        }
        
        dataTask.resume()
    }
}

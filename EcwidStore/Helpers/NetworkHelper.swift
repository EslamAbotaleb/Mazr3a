//
//  NetworkHelper.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import Foundation

enum NetworkHelper {
    
   static func handleNetworkResponse(_ responce: HTTPURLResponse , date: Data?)-> result<String> {

        switch responce.statusCode {
            
        case 200...299 : return .success

        default :
            guard date != nil else {
                return .failure(NetworkResponse.noDate.rawValue)
            }
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}


enum NetworkResponse: String {
    case success
    case tokenInvalid = "You need to request new token from firebase"
    case authanticationError = "You need to be authinticated"
    case badRequest = "Bad Request"
    case outDated = "The URL is outdated"
    case failed = "Network request failed"
    case noDate = "No Date to decode"
    case unableDecode = "Un able to decode the responce"
}

enum result<String> {
    case success
    case failure(String)
}

public enum NetworkError: String, Error {
    public typealias RawValue = String
    case parametersNil = "Parameters were nil"
    case encodingFaild = "Parameter encoding failed"
    case missingURl = "URL is nil"
}

enum StoreError: String , Error {
    case connectionError = "Unable to complete your request. Check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidDate = "The data received from the server is invalid. Please try again."
    case decodeError = "Unable to decode the data received from the server. Please try again."
}


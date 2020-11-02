//
//  Router.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter{
    
    private var task: URLSessionTask?
    
    func request(_ route:EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    print(response)
                    let result = NetworkHelper.handleNetworkResponse(response, date: data)
                    switch result {
                    case .failure( _):
                        completion(data, response , error)
                    case .success:
                        completion(data,response,error)
                    }
                }
            })
            task?.resume()
        } catch {
            completion(nil,nil,error)
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest{
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            switch route.task {
            case .request:
                break
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditonalHeader(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters? ,bodyEncoding: ParameterEncoding, urlParameters: Parameters? , request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditonalHeader(_ additionalHeaders: HTTPHeaders? , request: inout URLRequest){
        guard let headers = additionalHeaders else {return}
        for (key , value ) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

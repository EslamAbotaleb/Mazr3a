//
//  EndPointType.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod:HTTPMethod  {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders? {get}
}

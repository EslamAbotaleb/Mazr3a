//
//  Helpers.swift
//  EcwidStore
//
//  Created by Logista on 7/27/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import Foundation
enum Helpers{
    
    static  func handleDescriptionString(description:String) -> String{
        let prefix = "[lang=\"en\"]"
        let attString = description.html2Attributed
        if attString?.string.hasPrefix(prefix) ?? false {
            return String((attString?.string.deletingPrefix(prefix).dropLast(8) ?? ""))
        }else {
            return attString?.string ?? ""
        }
    }
    
}

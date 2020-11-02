//
//  CartModel.swift
//  EcwidStore
//
//  Created by Islam Abotaleb on 10/29/20.
//  Copyright © 2020 zeyad. All rights reserved.
//

import Foundation
class CartModel: NSObject, NSCoding {
     var  id: String = ""
     var  name: String = ""
     var  defaultDisplayedPriceFormatted: String = ""
    var  weight: Double = 0.0
     var  enabled: Bool = false
     var  itemDescription: String = ""
     var  imageURL:String = ""
     var  inStock: Bool = false
     var  discountsAllowed: Bool = false
 
//    var CartName: String {
//        get {
//            return name
//        }
//        set {
//            name = newValue
//        }
//    }
//    var Cartid: Int {
//        get {
//            return id
//        }
//        set {
//            id = newValue
//        }
//    }
//    var CartdefaultDisplayedPriceFormatted: String {
//        get {
//            return defaultDisplayedPriceFormatted
//        }
//        set {
//            defaultDisplayedPriceFormatted = newValue
//        }
//    }
//    var Cartweight: Double {
//        get {
//            return weight
//        }
//        set {
//            weight = newValue
//        }
//    }
//    var Cartenabled: Bool {
//        get {
//            return enabled
//        }
//        set {
//            enabled = newValue
//        }
//    }
//    var CartitemDescription: String {
//        get {
//            return itemDescription
//        }
//        set {
//            itemDescription = newValue
//        }
//    }
//
//    var CartimageURL: String {
//        get {
//            return imageURL
//        }
//        set {
//            imageURL = newValue
//        }
//    }
//
//    var CartinStock: Bool {
//        get {
//            return inStock
//        }
//        set {
//            inStock = newValue
//        }
//    }
//
//    var CartdiscountsAllowed: Bool {
//        get {
//            return discountsAllowed
//        }
//        set {
//            discountsAllowed = newValue
//        }
//    }
    
    init(CartName: String, Cartid: String,CartdefaultDisplayedPriceFormatted: String ,Cartweight: Double,Cartenabled: Bool,
         CartitemDescription: String,CartimageURL: String, CartinStock: Bool, CartdiscountsAllowed: Bool ) {

        name = CartName
        id = Cartid
        defaultDisplayedPriceFormatted = CartdefaultDisplayedPriceFormatted
        weight = Cartweight
        enabled = Cartenabled
        itemDescription = CartitemDescription
        imageURL = CartimageURL
        inStock = CartinStock
        discountsAllowed = CartdiscountsAllowed

    }

    required  init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        self.defaultDisplayedPriceFormatted = aDecoder.decodeObject(forKey: "defaultDisplayedPriceFormatted") as? String ?? ""
        self.weight = aDecoder.decodeObject(forKey: "weight") as? Double ?? 0.0
        self.enabled = aDecoder.decodeObject(forKey: "enabled") as? Bool ?? false
        self.itemDescription = aDecoder.decodeObject(forKey: "itemDescription") as? String ?? ""
        self.imageURL = aDecoder.decodeObject(forKey: "imageURL") as? String ?? ""
        self.inStock = aDecoder.decodeObject(forKey: "inStock") as? Bool ?? false
        self.discountsAllowed = aDecoder.decodeObject(forKey: "discountsAllowed") as? Bool ?? false
//        self.init(CartName: name, Cartid: id, CartdefaultDisplayedPriceFormatted: defaultDisplayedPriceFormatted, Cartweight: weight, Cartenabled: enabled, CartitemDescription: itemDescription, CartimageURL: imageURL, CartinStock: inStock, CartdiscountsAllowed: discountsAllowed)
//        self.init(playerName: name, playerScore: score, playerColor: color)
    }

    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(defaultDisplayedPriceFormatted, forKey: "defaultDisplayedPriceFormatted")
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(enabled, forKey: "enabled")
        aCoder.encode(itemDescription, forKey: "itemDescription")
        aCoder.encode(imageURL, forKey: "imageURL")
        aCoder.encode(inStock, forKey: "inStock")
        aCoder.encode(discountsAllowed, forKey: "discountsAllowed")
    }
    
    

}

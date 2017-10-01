//
//  Price.swift
//  ShoppingApp


import UIKit
import RealmSwift
import ObjectMapper

class Price:Object,Mappable {
    
    dynamic var formattedPrice:String = ""
    required convenience init?(map:Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        formattedPrice <- map["price.formatted"]
    }
}



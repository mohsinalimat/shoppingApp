//
//  Article.swift
//  ShoppingApp

import UIKit
import Foundation
import ObjectMapper
import RealmSwift
import Realm

class Article: Object, Mappable {
    
    dynamic var id: String = ""
    dynamic var modelId: String = ""
    dynamic var name: String  = ""
    dynamic var color:String = ""
    dynamic var price:String = ""
    dynamic var imageUrl:String = ""
    var units : List<Price> = List<Price>()
    var imageData: Data = Data()
    var images = List<Image>()
    var prices = List<Price>()
    
    required convenience init?(map:Map) {
        self.init()
    }
    
    // Realm mapping
    func mapping(map:Map) {
        id <- map["id"]
        name <- map["name"]
        color <- map["color"]
        modelId <- map["modelId"]
        var pricesArray:[Price]?
        pricesArray <- map["units"]
        
        for _price in pricesArray! {
            self.price = _price.formattedPrice
        }
        
        var imagesArray:[Image]?
        imagesArray  <- map["media.images"]
        
        if imagesArray != nil {
            for img in imagesArray! {
                self.images.append(img)
            }
        }
        
        self.imageData = (imagesArray?.first?.articleImageData)!
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}

class  ArticleList: Mappable {
    var articles:[Article] = []
    required init?(map:Map) {
        
    }
    
    func mapping(map:Map) {
        articles <- map["content"]
        
    }
}

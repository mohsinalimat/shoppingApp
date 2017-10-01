//
//  Image.swift
//  ShoppingApp

import UIKit
import RealmSwift
import ObjectMapper

class Image: Object,Mappable {
    dynamic var imageUrl:String = ""
    dynamic var articleImageData:Data = Data()
    required convenience init?(map:Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        imageUrl <- map["smallUrl"]
        
        let url = self.imageUrl
        let urlData = URL(string:url)
        let data = try? Data(contentsOf:urlData!)
        articleImageData = data!
     }
  }


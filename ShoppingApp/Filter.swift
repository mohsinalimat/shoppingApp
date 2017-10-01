//
//  Filter.swift
//  ShoppingApp


import UIKit
import Foundation
import ObjectMapper
import RealmSwift
import Realm

class Filter: Object,Mappable {

    dynamic var amountValue:String = ""
    dynamic var colorValue:String = ""
    required convenience init?(map:Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        // to do 
    }
}

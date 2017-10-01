//
//  Global.swift
//  ShoppingApp


import UIKit
import Foundation

class Global {
    static public func getUrl(_ path:String)-> String {
        let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as! String
        return "\(baseUrl)\(path)"
    }
}

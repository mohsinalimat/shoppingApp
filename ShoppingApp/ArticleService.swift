//
//  ArticleService.swift
//  ShoppingApp

let baseUrl = Bundle.main.infoDictionary?["BASE_URL"] as! String

import UIKit
import Foundation
import Alamofire
import Realm
import ObjectMapper
var filterleManager:FilterManager = FilterManager()

class ArticleService {
    
    func getArticles (onResponse: @escaping (_ success:ArticleList?,_ error:NSError?)->Void) {
        Alamofire.request(baseUrl+"articles?page=1&pageSize=5", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            if let json : NSDictionary = response.result.value as? NSDictionary {
                if let articleList = Mapper<ArticleList>().map(JSON:json as! [String: Any]) {
                    onResponse(articleList,nil)
                }else {
                    //TO DO Error Handling
                    onResponse(nil,nil)
                }
            }
        }
    }
    
    func getArticlesFromSearch (searchString:String,onResponse: @escaping (_ success:ArticleList?,_ error:NSError?)->Void) {
        let urlString = "articles/?page=1&pageSize=5&fullText=\(searchString)"
        let url = prepareUrlStringWithFilters(urlString: urlString)
        Alamofire.request(baseUrl+url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            if let json : NSDictionary = response.result.value as? NSDictionary {
                if let articleList = Mapper<ArticleList>().map(JSON:json as! [String: Any]) {
                    onResponse(articleList,nil)
                } else {
                    //TO DO Error Handling
                    onResponse(nil,nil)
                }
            }
        }
    }
    
    func prepareUrlStringWithFilters(urlString:String) -> String {
        var url:String = String()
        url = urlString
        let defaults = UserDefaults.standard
        if let colorFilter = defaults.object(forKey: "filterColor") {
            if !(colorFilter as! String  == "") {
                url = urlString+"&color=\(colorFilter)"
            }
        }
        if let amountValue = defaults.object(forKey: "filterAmount") {
            if !(amountValue as! String == "") {
                url = urlString+"&price=0-\(amountValue)"
            }
        }
        
        return url
    }
}

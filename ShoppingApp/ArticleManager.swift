//
//  ArticleManager.swift
//  ShoppingApp

import UIKit
import Foundation
import RealmSwift
import ObjectMapper

protocol ArticleManagerDelegate: class {
    func onSuccess()
    func onError()
}

class ArticleManager {
    weak var delegate : ArticleManagerDelegate?
    
    func getArticles() -> Results<(Article)>{
        let realm : Realm = try! Realm()
        return ArticleDAO().getAll(realm)
    }
    
    func getArticlesAt(index:Int) -> Article {
        return getArticles()[index]
    }
    
    
    func fetchArticles() {
        let realm: Realm = try! Realm()
        ArticleService().getArticles { (articleList:ArticleList?, error:NSError?) in
            if let articleList = articleList {
                ArticleDAO().update(realm, data: articleList.articles)
                self.delegate?.onSuccess()
            } else if let error = error {
                //TO DO ErrorHandling
                self.delegate?.onError()
                }
            }
        }
    
    func fetchArticlesFromSearch(searchString:String) {
        let realm: Realm = try! Realm()
        ArticleService().getArticlesFromSearch(searchString:searchString) { (articleList:ArticleList?, error:NSError?) in
            if let articleList = articleList {
                ArticleDAO().cleanSave(realm, data: articleList.articles)
                self.delegate?.onSuccess()
            //TO DO ErrorHandling
            } else if let error = error {
                self.delegate?.onError()
            }
        }
    }
    
    
    }


//
//  RealmDao.swift
//  ShoppingApp

import UIKit
import RealmSwift

class RealmDao<T: Object> {
    
    func getAll (_ realm: Realm) -> Results<T> {
        return realm.objects(T.self)
    }
    
    func get(_ realm: Realm) -> Results<T> {
        return realm.objects(T.self)
    }
    
    func cleanSave(_ realm: Realm , data:[T]) {
        let objectsToDelete = self.getAll(realm)
        
        try! realm.write {
            realm.delete(objectsToDelete)
        }
        
        try! realm.write {
            realm.add(data,update:true)
        }
    }
    
    func add(_ realm: Realm,data:[T]) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func update(_ realm: Realm,data:[T]) {
        try! realm.write {
            realm.add(data,update:true)
        }
    }
    
    func delete(_ realm: Realm,object:T) {
        try! realm.write {
            realm.delete(object)
        }
    }
}

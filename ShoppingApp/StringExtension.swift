//
//  StringExtension.swift
//  ShoppingApp
//
//  Created by Damir Ramic on 01/10/2017.
//  Copyright © 2017 Damir Ramich. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func localized() -> String {
    return NSLocalizedString(self,tableName:nil,bundle:Bundle.main,value:"",comment:"")
    }
    
    func containsWhiteSpace() -> Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    func  checkForWhiteSpace(searchString:String) -> String {
        if searchString.containsWhiteSpace() {
            let newString = searchString.replacingOccurrences(of: " ", with: "_")
            return newString
        } else {
            return searchString
        }
    }
    
    mutating func replace(_ originalString:String, with newString:String) {
        if self.containsWhiteSpace() {
            self = self.replacingOccurrences(of: originalString, with: newString)
        } 
    }
}

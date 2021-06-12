//
//  UserImg.swift
//  KyPayApiTester
//
//  Created by Chee Ket Yung on 11/06/2021.
//

import Foundation

struct UserImg : Codable {
    
    enum Ptype : String, Codable {
        
        case profile = "P"
        
        case identity = "I"
    }
    
    var id : String?
    
    var pid : Int?
    
    var ptype : Ptype?
    
    var url : String?
    
    var lastUpdated : Date?
    
}

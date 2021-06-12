//
//  UserAddress.swift
//  KyPayApiTester
//
//  Created by Chee Ket Yung on 11/06/2021.
//

import Foundation

struct UserAddress : Codable {
    
    enum AddrType : String, Codable{
        
        case residential = "R"
        
        case work = "W"
        
        case others = "O"
        
    }
    
    var id : String?
    
    var addrType : AddrType?
    
    var line1 : String?
    
    var line2 : String?
    
    var postCode : String?
    
    var city : String?
    
    var state : String?
    
    var country : String?
    
    var lastUpdated : Date?
}


//
//  UserPaymentTx.swift
//  KyPayApiTester
//
//  Created by Chee Ket Yung on 11/06/2021.
//

import Foundation

struct UserPaymentTx : Codable{
    
    enum UidType : String, Codable {
        
        case phone = "P"
        
        case email = "E"
        
        case user_id = "U"
    }
    
    enum Stat : String, Codable {
        
        case success = "S"
        
        case error = "E"
        
        case none = "N"
    }
    
    var id : String?
    
    var ud : String?
    
    var toUid : String?
    
    var toUidType : UidType?
    
    var amount : Double?
    
    var currency : String?
    
    var method : String?
    
    var stat : Stat?
    
    var statMessage : String?
    
    var lastUpdated : Date?

}

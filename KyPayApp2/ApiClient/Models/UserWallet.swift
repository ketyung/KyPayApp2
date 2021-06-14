//
//  UserWallet.swift
//  KyPayApiTester
//
//  Created by Chee Ket Yung on 11/06/2021.
//

import Foundation

struct UserWallet : Codable {
    
    enum WalletType : String, Codable {
        
        case business = "B"
        
        case personal = "P"
    }
    
    var id : String?
    
    var refId : String?
    
    var balance : Double?
    
    var currency : String?
    
    var type : WalletType?
    
    var lastUpdated : Date?
}
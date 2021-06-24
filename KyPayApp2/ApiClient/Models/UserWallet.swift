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
    
    var serviceAddrId : String?
    
    var serviceContactId : String?
   
    var serviceCustId : String?
   
    var serviceWalletId : String?

    var lastUpdated : Date?
    
    var refIdForService : String? {
        
        let w = UserWallet(id: id ?? "", refId: refId ?? "")
        
        if let encoded = try? JSONEncoder().encode(w) {
            //let str = String(decoding: encoded, as: UTF8.self)
            return encoded.base64EncodedString()
        }
        
        return nil 
    }
    
    var walletIDs : WalletIDs {
        
        var w = WalletIDs(custId: self.serviceCustId)
        w.addrId = self.serviceAddrId
        w.contactId = self.serviceContactId
        w.walletId = self.serviceWalletId
        w.refId = self.refId
        return w 
    }
    
}

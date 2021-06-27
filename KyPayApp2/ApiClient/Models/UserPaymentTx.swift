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
    
    
    enum TxType : String, Codable {
        
        case walletTopUp = "WT"
        case sendMoney = "SM"
        case receiveMoney = "RM"
        case payBill = "PB"
    }
    
    var id : String?
    
    var uid : String?
    
    var toUid : String?
    
    var toUidType : UidType?
    
    var txType : TxType?
    
    var walletRefId : String?
    
    var toWalletRefId : String? // use for when wallet send to another wallet
    
    var amount : Double?
    
    var currency : String?
    
    var method : String?
    
    var servicePaymentId : String?
    
    var stat : Stat?
    
    var statMessage : String?
    
    var lastUpdated : Date?

}

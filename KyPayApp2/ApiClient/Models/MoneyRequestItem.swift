//
//  MoneyRequest.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 08/07/2021.
//

import Foundation

struct MoneyRequestItem : Codable , Equatable {

    var id : String?
  
    var requestId : String?
  
    var toUserId : String?
    
    var phoneNumber : String?
    
    var amount : Double?
    
    var allowedPaymentMethods : [String]?
    
    var lastUpdated : Date?
    
    
    
    static func == (lhs: MoneyRequestItem, rhs: MoneyRequestItem) -> Bool {
        return (lhs.id == rhs.id && lhs.id == rhs.id) ||  lhs.phoneNumber == rhs.phoneNumber
    }
}

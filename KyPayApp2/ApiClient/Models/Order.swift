//
//  Orderr.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 05/07/2021.
//

import Foundation

struct Order : Codable {

    enum Status : String, Codable {
        
        case delivered  = "D"
        
        case new = "N"
        
        case partiallyDelivered = "PD"
    }
    
    var id : String?
    
    var uid : String?
    
    var walletRefId : String?
    
    var orders : [SellerOrder]?
    
    var total : Double?
    
    var paymentMethod : String?
    
    var currency : String?
    
    var dateOrdered : Date?
    
    var dateDelivered : Date?
    
    var status : Status?
    
    var lastUpdated : Date?
    
    
    mutating func add(order : SellerOrder) {
        
        if orders == nil {
            
            orders = []
        }
        
        orders?.append(order)
  
    }
    
}

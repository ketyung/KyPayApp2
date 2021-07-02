//
//  Biller.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 01/07/2021.
//

import Foundation

struct Biller : Codable {
    
    enum ByType : String, Codable {
        
        case accountNumber = "AN"
        
        case phoneNumber = "PN"
        
        case others = "O"
        
    }
    
    var id : String?
    
    var serviceBid : String?
    
    var payoutMethod : String?
    
    var name : String?
    
    var addrLine1 : String?
    
    var addrLine2 : String?
    
    var postCode : String?
    
    var city : String?
    
    var state : String?
    
    var country : String?
    
    var iconUrl : String?
    
    var status : String?
    
    var byType : ByType?
    
    // a regex string that is used to verify the
    // validity of the number
    var numberValidator : String?
    
    var lastUpdated: Date?
    
}

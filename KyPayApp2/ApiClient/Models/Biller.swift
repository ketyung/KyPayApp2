//
//  Biller.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 01/07/2021.
//

import Foundation

struct Biller : Codable {
    
    var id : String?
    
    var serviceBid : String?
    
    var name : String?
    
    var addrLine1 : String?
    
    var addrLine2 : String?
    
    var postCode : String?
    
    var city : String?
    
    var state : String?
    
    var country : String?
    
    var iconUrl : String?
    
    var status : String?
    
    var lastUpdated: Date?
    
}

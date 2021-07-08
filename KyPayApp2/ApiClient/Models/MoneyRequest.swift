//
//  MoneyRequest.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 08/07/2021.
//

import Foundation

struct MoneyRequest : Codable {
    
    var id : String?
    
    var items : [MoneyRequestItem]?
    
    var total : Double?
    
    var dateRequested : Date?
   
    var lastUpdated : Date?

}

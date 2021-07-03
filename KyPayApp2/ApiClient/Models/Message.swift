//
//  Message.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 03/07/2021.
//

import Foundation

struct Message : Decodable {
    
    enum MessageType : String, Decodable {
        
        case moneyReceived = "SM"
        
        case moneyRequestedByOthers = "RM"
    }
    
    var id : String?

    var uid : String?
    
    var itemId : String?

    var title : String?
    
    var subTitle : String?
    
    var type : MessageType?
    
    var lastUpdated : Date?
}

//
//  PaymentSuccess.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 21/06/2021.
//

import Foundation

struct PaymentData {
    
    
    var id : String?
    
    enum Status : String {
        
        case created
        
        case none
    }
    
    var amount : Double?
    
    var curreny : String?
    
    var dateCreated : Date?
    
    var redirectURL : URL?
    
    var status : Status?
}

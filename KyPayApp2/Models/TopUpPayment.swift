//
//  TopUpPayment.swift
//  KyPayApp2
//
//  Created by Christopher Chee on 21/06/2021.
//

import Foundation

struct TopUpPayment {
    
    
    enum Status : Int {
        
        case success
        
        case created
        
        case failure
        
        case none 
    }
    
    var amount : Int?
    
    var errorMessage : String?
    
    var currency : String?
    
    var paymentMethod : PaymentMethod?
    
    var paymentStatus : Status?
    
    var redirectURL : URL?

    var serviceId : String?
}

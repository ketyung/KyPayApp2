//
//  TopUpPayment.swift
//  KyPayApp2
//
//  Created by Christopher Chee on 21/06/2021.
//

import Foundation

struct TopUpPayment {
    
    var amount : Int?
    
    var errorMessage : String?
    
    var currency : String?
    
    var paymentMethod : PaymentMethod?
    
    var paymentSuccess : Bool?
    
    var redirectURL : URL?

}

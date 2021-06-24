//
//  CardPayment.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 24/06/2021.
//

import Foundation

struct CardPayment {
    
    var number : String?
    
    var cvv : String?
    
    var expiryDate : String?
    
    var cardType : String.CardType {
        
        if let number = number {
            
            return number.replace(" ", "").getCreditCardType()
        }
        
        return .none
    }
    
    var isSupportedCardType : Bool {
        
        (cardType == .master || cardType == .visa)
    }
    
}

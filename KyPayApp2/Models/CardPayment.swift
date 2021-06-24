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
    
    
    var asCard : Card {
        
        var card = Card()
        
        if let number = number {
            
            card.number = number.replace(" ", "")
        }
        
        card.cardType = self.cardType
        card.cvv = self.cvv ?? ""
        
        let exps = self.expiryDate?.components(separatedBy: "/")
        
        if let month = exps?.first {
            
            card.expirationMonth = Int(month) ?? 0
        }
        
        if let year = exps?[safe:1] {
            
            card.expirationYear = Int(year) ?? 0
        }
        
        return card
    }
}

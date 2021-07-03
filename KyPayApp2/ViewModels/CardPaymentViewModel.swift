//
//  CardPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 24/06/2021.
//

import Foundation

class CardPaymentViewModel : ObservableObject {
    
    @Published private var cardPayment = CardPayment()
    
    @Published var errorMessage : String? = nil
    
    var number : String {
        
        get {
            
            return cardPayment.number ?? ""
        }
        
        set(newVal){
            
            var num = newVal.replace(" ", "").separate(every: 4)
            
            if num.count  > 19 {
                
                num = String(num.prefix(19))
            }
            
            cardPayment.number = num
            
          //  self.validateCard()
            
        }
    }
    
    var expiryDate : String {
        
        get {
            
            return cardPayment.expiryDate ?? ""
        }
        
        set(newVal){
    
            var val = newVal.replace("/", "").separate(every: 2, with: "/")
            
            if val.count  > 5 {
                
                val = String(val.prefix(5))
            }
            
            cardPayment.expiryDate = val
        }
    }
    
    var cvv : String {
        
        get {
            
            cardPayment.cvv ?? ""
        }
        set(newVal){
            
            cardPayment.cvv = newVal
        }
    }
    
    
    var asCard : Card {
        
        get{
            cardPayment.asCard
        }
    }
}

extension CardPaymentViewModel {
    
    private func validateCard(){
        
        if !cardPayment.isSupportedCardType {
            
            errorMessage = "Only VISA and Master allowed!".localized
        }
        else {
            
            errorMessage = nil
        }
    }
    
    
    private func validateAll(){
        
        if !cardPayment.isSupportedCardType {
            
            errorMessage = "Only VISA and Master allowed!".localized
            return 
        }
        else {
            
            errorMessage = nil
        }
        
        if expiryDate.isEmpty {
            
            errorMessage = "Invalid card expiry date".localized
            return
        }
        else {
            
            errorMessage = nil
        }
        
        if cvv.isEmpty {
            
            errorMessage = "Invalid card cvv".localized
            return
        }
        else {
            
            errorMessage = nil
        }
        
    }
    
    
    func isValid() -> Bool {
    
        self.validateAll()
        
        guard let _ = self.errorMessage else {
            
            return true
        }
    
        return false
    }
}

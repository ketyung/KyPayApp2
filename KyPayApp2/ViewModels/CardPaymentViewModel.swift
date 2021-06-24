//
//  CardPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 24/06/2021.
//

import Foundation

class CardPaymentViewModel : ObservableObject {
    
    @Published private var cardPayment = CardPayment()
    
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
}

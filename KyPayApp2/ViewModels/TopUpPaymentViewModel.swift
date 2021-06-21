//
//  TopUpPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation
import SwiftUI

class TopUpPaymentViewModel : ObservableObject {
    
    @Published private var topUpPayment = TopUpPayment()
    
    var errorMessage : String? {
        
        get {
            
            topUpPayment.errorMessage 
        }
    }
    
    var paymentMethod : PaymentMethod? {
        
        get {
            
            topUpPayment.paymentMethod
        }
        
        set(newVal){
            
            topUpPayment.paymentMethod = newVal
        }
    }
    
    
    var amount : String {
        
        get {
            "\(topUpPayment.amount ?? 0)"
        }
        
        set(newVal){
            
            var amtTxt = newVal
            
            if amtTxt.count > 4 {
                
                amtTxt =  String(amtTxt.prefix(4))
            }
            
            let amt = Int(amtTxt)
            
            withAnimation{
            
                if (amt ?? 0)  > 2000 {
                    
                    topUpPayment.errorMessage = "Maximum amount : <curr> 2000"
                }
                else {
                    
                    topUpPayment.errorMessage = nil
                }
            }
            
            topUpPayment.amount = amt
        
        }
    }
}

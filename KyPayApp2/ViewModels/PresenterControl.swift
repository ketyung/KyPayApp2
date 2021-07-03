//
//  PresenterControl.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import Foundation

struct PresenterControl {
    
    var topUpPresented : Bool = false
    
    var sendMoneyPresented : Bool = false
    
    var requestMoneyPresented : Bool = false
    
    var paymentMethodSelectorPresented : Bool = false
   
    var cardPaymentPresented : Bool = false
   
    var payoutMethodSelectorPresented : Bool = false
   
    var topUpPaymentPresented : Bool = false
   
    var billerPaymentPresented : Bool = false
    
    
    mutating func reset(){
        
        topUpPresented = false
        sendMoneyPresented = false
        requestMoneyPresented = false
        payoutMethodSelectorPresented = false
        payoutMethodSelectorPresented = false
        topUpPaymentPresented = false
        billerPaymentPresented = false
    }
}

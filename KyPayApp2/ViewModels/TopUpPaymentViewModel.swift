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
    
    @Published private var showingProgressIndicator : Bool = false
    
    private lazy var walletHandler = WalletHandler()
    
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
    
    var currency : String {
        
        get {
            
            topUpPayment.currency ?? "MYR"
        }
        
        set(newVal){
            
            topUpPayment.currency = newVal
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
    
    var progressIndicatorPresented : Bool {
        
        get {
            
            showingProgressIndicator
        }
        
        set(newVal){
            
            showingProgressIndicator = newVal
        }
    }
}



extension TopUpPaymentViewModel {
    
    func add(customerId : String) {
        
        
        if let amount = topUpPayment.amount , let currency = topUpPayment.currency {
      
            self.showingProgressIndicator = true
          
            walletHandler.add(card : Card(), amount: Double(amount), currency: currency,
                              customerId: customerId , completion: {
            
                [weak self] payment, error in
                
                guard let self = self else { return }
                
                guard let err = error else {
                    
                    self.showingProgressIndicator = false
                    return
                }
                
                print("add.xx.error.making.payment@.:\(String(describing: err))")
           
                
                self.topUpPayment.errorMessage = err.localizedDescription
                self.showingProgressIndicator = false
                
            })
        }
        
       
        
    }
}

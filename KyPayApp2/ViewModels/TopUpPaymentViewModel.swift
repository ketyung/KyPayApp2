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
                
                else if (amt ?? 0) < 5 {
                    
                    topUpPayment.errorMessage = "Manimum amount : <curr> 5"
              
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
    
    
    var paymentSuccess : Bool {
        
        get {
            
            topUpPayment.paymentSuccess ?? false
        }
        
        set(newVal){
            
            topUpPayment.paymentSuccess = newVal
        }
    }
}


/**
extension TopUpPaymentViewModel {
    
    func add(customerId : String, card : Card) {
        
        if let amount = topUpPayment.amount , let currency = topUpPayment.currency {
      
            self.showingProgressIndicator = true
          
            walletHandler.add(card : card, amount: Double(amount), currency: currency,
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
    
    
    
    
    func add(customerId : String) {
    
        if let amount = topUpPayment.amount , let currency = topUpPayment.currency, let paymentMethod = topUpPayment.paymentMethod {
      
            self.showingProgressIndicator = true
          
            walletHandler.add(amount: Double(amount), currency: currency, paymentMethod: paymentMethod, customerId: customerId , completion: {
            
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
 */

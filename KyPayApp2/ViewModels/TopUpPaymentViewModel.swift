//
//  TopUpPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation
import SwiftUI
import WebKit

class TopUpPaymentViewModel : NSObject, ObservableObject {
    
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
    
    
    var paymentStatus : TopUpPayment.Status {
        
        get {
            
            topUpPayment.paymentStatus ?? .none
        }
        
        set(newVal){
            
            topUpPayment.paymentStatus = newVal
        }
    }
    
    
    var redirectURL : URL? {
        
        get {
            
            topUpPayment.redirectURL
        }
        
        set(newVal){
            
            topUpPayment.redirectURL = newVal
        }
    }
    
    
    var servicePaymentId : String? {
        
        get {
            
            topUpPayment.servicePaymentId 
        }
        
        set(newVal){
            
            topUpPayment.servicePaymentId = newVal
        }
    }
}


extension TopUpPaymentViewModel : WKNavigationDelegate{
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //self.evaluateJs(webView)
        
        if webView.url?.absoluteString == WalletHandler.completionURL {
            
            self.paymentStatus = .success
        }
        else if webView.url?.absoluteString == WalletHandler.errorURL {
            
            self.paymentStatus = .failure
        }
        
        print("self.paymentStatus::\(self.paymentStatus)::\(self.servicePaymentId ?? "xxxx")::\(self.paymentMethod?.type ?? "")")
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

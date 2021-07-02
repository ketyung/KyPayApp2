//
//  BillerPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 02/07/2021.
//

import Foundation
import SwiftUI

class BillerPaymentViewModel : ObservableObject {
    
    
    @Published private var billerPayment  = BillerPayment()
    
    
    var amount : Double {
        
        get {
            
            billerPayment.amount?.roundTo(places: 2) ?? 0
        }
        
        set(newVal){
            
            billerPayment.amount = newVal
        }
        
    }
    
    var amountText : String {
        
        get {
            
            (billerPayment.amount ?? 0).twoDecimalString
        }
        
        set(newVal){
            
            billerPayment.amount = Double(newVal)
        }
    }
    
    
    var number : String {
        
        get {
            
            billerPayment.number ?? ""
        }
        
        set(newVal){
            
            billerPayment.number = newVal
            
            self.validateNumberAndAlertIfInvalid()
        }
        
        
    }
    
    
    var biller : Biller? {
        
        get {
            
            billerPayment.biller
        }
        
        set(newVal) {
            
            billerPayment.biller = newVal
        }
    }
    
    
    var errorMessage : String {
        
        get {
            
            billerPayment.errorMessage ?? ""
        }
    }
    
    var errorPresented : Bool {
        
        get {
            
            billerPayment.errorPresented ?? false
        }
        
        set(newVal){
            
            billerPayment.errorPresented = newVal
        }
    }
}


extension BillerPaymentViewModel {
    
    func reset(){
        
        billerPayment.biller = nil
        billerPayment.amount = nil
        billerPayment.number = nil
        billerPayment.errorPresented = nil
        billerPayment.errorMessage = nil
    }
    
    
    
    private func validateNumberAndAlertIfInvalid() {
        
        if !validateNumber() {
            
            if biller?.byType == .accountNumber {
                
                self.billerPayment.errorMessage = "Invalid account number".localized
                withAnimation{
          
                    self.billerPayment.errorPresented = true
                }
            }
            else if biller?.byType == .phoneNumber {
                
                
                self.billerPayment.errorMessage = "Invalid phone number".localized
                withAnimation{
          
                    self.billerPayment.errorPresented = true
              
                }
         
            }
        }
        else {
            
            withAnimation{
                
                self.billerPayment.errorMessage = nil
                self.billerPayment.errorPresented = false 
            }
            
        }
    }
    
    
    private func validateNumber() -> Bool{
        
        if let regexPattern = billerPayment.biller?.numberValidator {
            
            let test = NSPredicate(format: "SELF MATCHES %@", regexPattern)
            let result = test.evaluate(with: self.number)
            return result
            
        }
        
        return true // default to true if no pattern available
    }
    
}

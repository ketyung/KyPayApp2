//
//  BillerPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 02/07/2021.
//

import Foundation

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
    
}


extension BillerPaymentViewModel {
    
    func reset(){
        
        billerPayment.biller = nil
        billerPayment.amount = nil
        billerPayment.number = nil
    }
}

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
    
    private lazy var payoutHandler = PayoutHandler()
    
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
    
    var success : Bool {
        
        get {
            
            billerPayment.success ?? false
        }
        
        set(newVal){
            
            billerPayment.success = newVal
        }
    }
    
    var inProgress : Bool {
        
        get {
            
            billerPayment.inProgress ?? false
        }
        
        set(newVal){
            
            billerPayment.inProgress = newVal
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
        billerPayment.success = nil
        billerPayment.inProgress = nil
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

extension BillerPaymentViewModel {
    
    func proceed(from user : User,  walletViewModel : UserWalletViewModel){
        
        if amount <= 0 {
            
            self.send(error: CustomError(errorText: "Invalid amount!".localized))
            return
        }
        
        
        if number.isEmpty {
            
            self.send(error: CustomError(errorText: "Invalid number!".localized))
            return
        }
        
        self.billerPayment.errorMessage = nil
        self.errorPresented = false
        
        self.inProgress = true
        
        if !errorPresented, let biller = biller {
            
            /// should proceed while no error!
            self.payoutHandler.issuePayout(from: user, walletSenderID: walletViewModel.walletSenderID, for: biller, amount: amount, number: number, completion: {
                
                [weak self] payoutId, senderId, err in
                
               // print("po.id::\(String(describing: payoutId))::sd.id::\(String(describing: senderId))")
                
                guard let err = err else {
              
                    
                    if let payoutId = payoutId, let senderId = senderId {
                    
                        walletViewModel.updateWalletRemotely(payOutTo: biller, user: user, amount: self?.amount ?? 0, number: self?.number ?? "", senderId: senderId, serviceId: payoutId, completion: {err in
                            
                            guard let err = err else {
                                
                                DispatchQueue.main.async {
                                    withAnimation{
                                        self?.success = true
                                        self?.inProgress = false
                                    }
                                }
                                   
                                return
                                
                            }
                            
                            self?.send(error: err)
                            
                        })
                        
                        
                    }
                    
                    
                 
                    return
             
                    
                }
                
                
                if let senderId = senderId {
                    
                    walletViewModel.updateWalletRemotely(with: senderId, for : user, completion: {_ in
                        
                        self?.send(error: err)
                        return
                    })
                }
                
                
                
                self?.send(error: err)
          
                
            })
            
        }
    }
    
    
    private func send(error : Error?){
        
        DispatchQueue.main.async {
         
            withAnimation{
           
                self.billerPayment.errorMessage = error?.localizedDescription
                self.errorPresented = true
                self.inProgress = false 
               
            }
            
        }
    }
    
   
    
}

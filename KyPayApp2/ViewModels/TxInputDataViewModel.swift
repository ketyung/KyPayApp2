//
//  TxInputDataViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import Foundation
import SwiftUI

class TxInputDataViewModel : NSObject, ObservableObject {
    
    @Published private var txInputData = TxInputData()
    
    private let syncer = KyPayUserSyncer()
    
    
    var shouldPresentContactList : Bool {
        
        get {
            
            txInputData.shouldPresentContactList
        }
    }
    
    var showProgressIndicator : Bool {
        
        get {
            
            txInputData.showProgressIndicator
        }

        set(newVal){
            
            txInputData.showProgressIndicator = newVal
        }
    }
    
    var showAlert : Bool {
        
        get {
            
            txInputData.showAlert
        }
        
        set(newVal){
            
            txInputData.showAlert = newVal
        }
        
    }
    
    var alertMessage : String {
        
        get {
            
            txInputData.alertMessage ?? ""
        }
    }
    
    var phoneNumberBeingVerified : Bool {
        
        get {
            txInputData.phoneNumberBeingVerified
        }
    }
    
    var shouldProceedNext : Bool {
        
        get {
            
            txInputData.shouldProceedNext
        }
        
        set(newVal){
            
            txInputData.shouldProceedNext = newVal
        }
    }
    
    var phoneNumberVerified : Bool {
        
        get {
            txInputData.phoneNumberVerified
        }
    }
    
    
    var txAmount : Double {
        
        get {
            
            txInputData.txAmount ?? 0
        }
        
        set(newVal){
            
            txInputData.txAmount = newVal
        }
    }
    
    
    var selectedUserName : String {
        
        "\(txInputData.selectedUser?.firstName ?? "") \(txInputData.selectedUser?.lastName ?? "")"
    }
    
    var selectedUserPhoneNumber : String {
        
        txInputData.selectedUser?.phoneNumber ?? ""
    }
}

extension TxInputDataViewModel {
    
    func syncContact(){
        
        
        if KDS.shared.lastSyncedDateLonger(than: 1800){
            withAnimation{
                
                self.txInputData.showProgressIndicator = true
            }
           
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
           
                self.syncer.syncNow(completion: { [weak self]
                    
                    _ in
                    
                    guard let self = self else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                    
                        withAnimation{
                            self.txInputData.showProgressIndicator = false
                        }
                    }
                    
                    
                })
            }
           
           
        }
    }
}

extension TxInputDataViewModel {
    
    
    func verifyIfPhoneNumberExists(_ phoneNumber : String ){
        
        withAnimation{
       
            txInputData.phoneNumberBeingVerified = true
        }
        
        if !phoneNumber.isValidPhone() {
            
            sendFailureMessage("Invalid Phone Number!")
            withAnimation{
                txInputData.phoneNumberBeingVerified = false
            }
            return
        }
        
        
        ARH.shared.fetchUser(phoneNumber: phoneNumber, completion: { [weak self]
            
            res in
        
            guard let self = self else {
                
                return
            }
            
            DispatchQueue.main.async {
            
                switch(res) {
                
                    case .failure(let err):
                        
                        self.txInputData.selectedUser = nil
                        self.shouldProceedNext = false
                        if let err = err as? ApiError, err.statusCode == 404 {
                            
                            self.sendFailureMessage("The phone number is not a KyPay user")
                        }
                        else {
                            
                            self.sendFailureMessage(err.localizedDescription)
                        }
                      
                    
                    case .success(let usr) :
                        if usr.phoneNumber == phoneNumber {
                            
                            self.txInputData.selectedUser = usr
                            
                            withAnimation{
                   
                                self.txInputData.phoneNumberVerified = true
                                self.txInputData.alertMessage = "\(usr.firstName ?? "") \(usr.lastName ?? "")".localized
                                self.txInputData.showAlert = true
                                
                                if !self.shouldProceedNext {
                                    self.shouldProceedNext = true
                                }
                               
                            }
                        }
                
                }
                
                withAnimation{
       
                    self.txInputData.phoneNumberBeingVerified = false
                   
                }
                
            }
            
        })
    }
    
    
    private func sendFailureMessage ( _ message : String ){
        
        withAnimation{
       
            self.txInputData.alertMessage = message.localized
            self.txInputData.showAlert = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            
            withAnimation{
                
                self.txInputData.showAlert = false
            }
        })
    }
}

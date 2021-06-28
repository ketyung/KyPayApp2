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
    
    private lazy var cachedAttemptDS = CRTADS()
    
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
    
    var selectedUserId : String {
        
        txInputData.selectedUser?.id ?? ""
    }
    
    var selectedUserWalletRefId : String {
        
        txInputData.selecteduserWalletRefId ?? ""
    }
    
    func clearForRestart(){
        
        txInputData.shouldProceedNext = false 
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
    
    func verifyIfPhoneNumberExists(_ phoneNumber : String, completion : (() -> Void)? = nil ) {
        
        withAnimation{
       
            txInputData.phoneNumberBeingVerified = true
        }
        
        if !phoneNumber.isValidPhone() {
            
            sendFailureMessage("Invalid Phone Number!")
            withAnimation{
                txInputData.phoneNumberBeingVerified = false
            }
            completion?()
            return
        }
        
        self.verifyPhoneNumberFromRemote(phoneNumber: phoneNumber, completion:  completion)
     
    }
    
    
    private func verifyPhoneNumberFromRemote( phoneNumber : String, completion : (() -> Void)? = nil) {
        
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
                        completion?()
               
                    
                    case .success(let usr) :
                        if usr.phoneNumber == phoneNumber {
                            
                            self.fetchUserWalletInfo(user: usr, completion:  completion)
                        }
                            
                }
               
               
                withAnimation{
       
                    self.txInputData.phoneNumberBeingVerified = false
                   
                }
                
            }
            
        })
    }
    
    
    private func fetchUserWalletInfo(user : User,  completion : (() -> Void)? = nil){
        
        ARH.shared.fetchUserWallet(id: user.id ?? "", type:.personal, currency: "MYR", completion: {
            
            res  in
        
            switch (res) {
            
                case .failure(let err) :
                    
                    if let err = err as? ApiError, err.statusCode == 404 {
                        
                        self.sendFailureMessage("The user does NOT have a wallet")
                    }
                    else {
                        
                        self.sendFailureMessage(err.localizedDescription)
                    }
                
                    completion?()
                    
                case .success(let obj) :
                
                  
                    DispatchQueue.main.async {
                     
                        self.txInputData.selectedUser = user
                   
                        self.txInputData.selecteduserWalletRefId = obj.refId
                        
                       
                        self.txInputData.phoneNumberVerified = true
                        
                        self.save(attempt: user.phoneNumber ?? "", name: "\(user.firstName ?? "") \(user.lastName ?? "")")
                       
                        withAnimation{
                       
                            if !self.shouldProceedNext {
                                self.shouldProceedNext = true
                            }
                           
                        }
                       
                       
                        completion?()
                       
                    }
                    
                
            
            }
            
            
        } )
       
    }
    
    
    
    private func sendFailureMessage ( _ message : String ){
        
        DispatchQueue.main.async {
         
            withAnimation{
           
                self.txInputData.alertMessage = message.localized
                self.txInputData.showAlert = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            
            withAnimation{
                
                self.txInputData.showAlert = false
            }
        })
    }
}


extension TxInputDataViewModel {
    
    func fetchRecentAttempts() -> [CachedRecentTxAttempt]{
        
       return cachedAttemptDS.recent() ?? []
    }
    
    func save(attempt phoneNumber : String, name : String){
        
        cachedAttemptDS.saveAttempt(phoneNumber: phoneNumber, name: name)
    }
}

//
//  TxInputDataViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import Foundation
import SwiftUI
import AVFoundation

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
    
    
    var txAmountText : String {
        
        get {
            
            txAmount.twoDecimalString
        }
        
        set(newVal){
            
            txInputData.txAmount = Double(newVal)
        }
    }
    
    
    var txAmount : Double {
        
        get {
            
            txInputData.txAmount?.roundTo(places: 2) ?? 0
        }
        
        set(newVal){
            
            txInputData.txAmount = newVal
        }
    }
    
    
    var note : String {
        
        get {
            
            txInputData.note ?? ""
        }
        
        set(newVal){
            
            var val = newVal
            if val.count  > 50 {
                
                val = String(val.prefix(50))
            }
           
         
            txInputData.note = val
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
    
    func reset(){
        
        txInputData.shouldProceedNext = false
        txInputData.alertMessage = nil
        txInputData.phoneNumberBeingVerified = false
        txInputData.selectedUser = nil
        txInputData.selecteduserWalletRefId = nil
        txInputData.showProgressIndicator = false
        txInputData.phoneNumberVerified = false
        txInputData.showAlert = false
        txInputData.txAmount = 0
        txInputData.shouldPresentContactList = false

    }
    
}

extension TxInputDataViewModel {
    
    func syncContact(forceSyncing : Bool = false, completion : (()->Void)? = nil ){
        
        
        if KDS.shared.lastSyncedDateLonger(than: 1800) || forceSyncing{
            
            withAnimation{
                
                self.txInputData.showProgressIndicator = true
            }
           
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
           
                self.syncer.syncNow( completion: { [weak self]
                    
                    _ in
                    
                    guard let self = self else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                    
                        withAnimation{
                            self.txInputData.showProgressIndicator = false
                        }
                    }
                    
                    completion?()
                    
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
        
        
        // need.to.change.the.hard.coded.currency.x
        
        let currency = CurrencyManager.currency(countryCode: user.countryCode ?? "MY")
        
        ARH.shared.fetchUserWallet(id: user.id ?? "", type:.personal, currency: currency ?? "MYR", completion: {
            
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
    
    
}
 

extension TxInputDataViewModel {
 
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
    
    func fetchRecentAttempts() -> [CachedRecentTxAttempt]{
        
       return cachedAttemptDS.recent() ?? []
    }
    
    func save(attempt phoneNumber : String, name : String){
        
        cachedAttemptDS.saveAttempt(phoneNumber: phoneNumber, name: name)
    }
    
    
    func alertWithSound() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            AudioServicesPlayAlertSound(SystemSoundID(1103))
        })

    }
}

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
    
    var phoneNumberVerified : Bool {
        
        get {
            
            txInputData.phoneNumberVerified
        }
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
        
        txInputData.phoneNumberBeingVerified = true
        
        print("ve...phone::\(phoneNumber)")
        
        ARH.shared.fetchUser(phoneNumber: phoneNumber, completion: { [weak self]
            
            res in
        
            guard let self = self else {
                
                return
            }
            
            DispatchQueue.main.async {
            
                switch(res) {
                
                    case .failure(_):
                        
                        self.txInputData.alertMessage = "The phone number is not a KyPay user".localized
                        self.txInputData.showAlert = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                            
                            withAnimation{
                                
                                self.txInputData.showAlert = false
                            }
                        })
                    
                    case .success(let usr) :
                        if usr.phoneNumber == phoneNumber {
                            
                            self.txInputData.phoneNumberVerified = true
                            self.txInputData.alertMessage = "\(usr.firstName ?? "") \(usr.lastName ?? "")".localized
                            self.txInputData.showAlert = true
                        }
                
                }
                
                self.txInputData.phoneNumberBeingVerified = false
                
            }
            
        })
    }
}

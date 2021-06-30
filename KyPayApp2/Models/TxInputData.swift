//
//  TxInputData.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import Foundation

struct TxInputData {
    
    var shouldPresentContactList : Bool = false 
    
    var showProgressIndicator : Bool = false
    
    var showAlert : Bool = false
    
    var alertMessage : String?
    
    var phoneNumberBeingVerified : Bool = false
    
    var phoneNumberVerified : Bool = false
    
    var shouldProceedNext : Bool = false 
    
    var txAmount : Double?
    
    var note : String?
    
    var selectedUser : User?
    
    var selecteduserWalletRefId : String?
    
}

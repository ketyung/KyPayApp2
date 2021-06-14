//
//  PhoneAuthenticator.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import FirebaseAuth

class PhoneAuthenticator : NSObject{
    
    
    func authenticate(phoneNumber : String){
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {
          verificationID, error in
          
            if let error = error {
           
                print("auth.err:\(error)")
                return
            }
            
        }
    }
    
}

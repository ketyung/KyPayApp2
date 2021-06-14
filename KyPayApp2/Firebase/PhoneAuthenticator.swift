//
//  PhoneAuthenticator.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import FirebaseAuth

typealias PA = PhoneAuthenticator


class PhoneAuthenticator : NSObject{
    
    
    static let shared = PA()
    
    func sendOTP(phoneNumber : String, delegate : AuthUIDelegate? = nil ){
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: delegate) {
          verificationID, error in
          
            if let error = error {
           
                print("auth.err:\(error)")
                return
            }

            if let vid = verificationID {
           
                KDS.shared.saveFBVid(vid)
               
            }
            
        }
    }
    
}


extension PhoneAuthenticator {
    
    
    func signIn(_ verificationCode : String) {
        
        if let vid = KDS.shared.getFBVid() {
   
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: vid,
                verificationCode: verificationCode)
       
            Auth.auth().signIn(with: credential, completion: {
                
                authres , err in
                
                if let err = err {
    
                    print("Err::!\(err)")
                    return
                }
                
                print("authres?.user.phoneNumber::\(authres?.user.phoneNumber ?? "")")
                
            })
            
        }
        
        
    }
}

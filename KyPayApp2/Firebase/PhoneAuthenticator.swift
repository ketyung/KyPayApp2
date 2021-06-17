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
    
    func sendOTP(phoneNumber : String, completion : ( (Error?)->Void )? = nil  ){
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { 
          verificationID, error in
          
            if let error = error {
           
                if let completion = completion {
                    
                    completion(error)
                }
           
                return
            }

          
            if let vid = verificationID {
           
                KDS.shared.saveFBVid(vid)
           
                if let completion = completion {
                    
                    completion(nil)
                }
            }
            
        }
    }
    
}


extension PhoneAuthenticator {
    
    
    func signIn(verificationCode : String, completion: ((String?,Error?) -> Void)? = nil ) {
        
        if let vid = KDS.shared.getFBVid() {
   
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: vid,
                verificationCode: verificationCode)
       
            Auth.auth().signIn(with: credential, completion: {
                
                authres , err in
                
                if let err = err {
    
                    completion?(nil, err)
                    
                    return
                }
                
                completion?(authres?.user.phoneNumber, nil)
            
                KDS.shared.removeFBVid()
                
                // print("authres?.user.phoneNumber::\(authres?.user.phoneNumber ?? "")")
                
            })
            
        }
        
        
    }
}

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
    
    func authenticate(phoneNumber : String){
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {
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

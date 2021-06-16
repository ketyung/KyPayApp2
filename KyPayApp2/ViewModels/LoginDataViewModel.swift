//
//  LoginViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation

class LoginDataViewModel : NSObject, ObservableObject {
    
    
    @Published private var loginData : LoginData = LoginData()
    
    
    var selectedCountry : Country? {
        
        get {
            
            return loginData.selectedCountry
        }
        
        set(newVal){
            
            loginData.selectedCountry = newVal
        }
    }
    
    
    var enteredPhoneNumber : String {
        
        get {
            
            return loginData.enteredPhoneNumber
        }
        
        set(newVal){
            
            loginData.enteredPhoneNumber = newVal
        }
    }

    
    var phoneNumberIsFirstResponder : Bool {
        
        get {
            
            return loginData.phoneNumberIsFirstResponder
        }
        
        set(newVal){
            
            loginData.phoneNumberIsFirstResponder = newVal
        }
    }
    
    
    var isCountryPickerPresented : Bool {
        
        get {
            
            return loginData.isCountryPickerPresented
        }
        
        set(newVal){
            
            loginData.isCountryPickerPresented = newVal
        }
    }
    
    
    var isOTPViewPresented : Bool {
        
        get {
            
            loginData.isOTPViewPresented
        }
        
        set(newVal){
            
            loginData.isOTPViewPresented = newVal
        }
    }
}


extension LoginDataViewModel {
    
    
    func sendOTP(phoneNumber : String, completion : ( (Error?)->Void )? = nil ){
        
        PA.shared.sendOTP(phoneNumber: phoneNumber, completion: { err in
            
            if let err = err {
                
                if let completion = completion {
                    
                    completion(err)
                }
                
                return
            }
            
            self.loginData.isOTPViewPresented = true
            
            
            if let completion = completion {
                
                completion(nil)
            }
        
            
        })
    }
    
}



extension LoginDataViewModel {
    
    
    func signIn (verificationCode : String, completion : ((Bool,Error?)->Void)? = nil  ){
        
        PA.shared.signIn(verificationCode: verificationCode, completion: {
            phoneNumber, err in
            
            if let err = err {
                
                completion?(false, err)
                return
            }
            
            
            if let phone = phoneNumber {
           
                
                ARH.shared.fetchUser(phoneNumber: phone, completion: {
                    
                    res in
                    
                    switch (res) {
                    
                        case .failure(let err) :
                            if let err = err as? ApiError, err.statusCode == 404 {
                                // indicate first sign in if NOT found!
                                completion?(true, nil)
                                
                            }
                            else {
                            
        
                                completion?(false, err)
                            }
                            
                        case .success(let rr) :
                            
                            // save the user info
                            KDS.shared.saveUser(rr)
                            
                            completion?(false, nil)
                            
                    }
                    
                })
               
            }
            
        })
    }
}

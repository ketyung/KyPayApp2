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
        
        PA.shared.sendOTP(phoneNumber: phoneNumber, completion: {[weak self] err in
            
            if let err = err {
                
                if let completion = completion {
                    
                    completion(err)
                }
                
                return
            }
            
            guard let self = self else {
                
                return
            }
            
            if let completion = completion {
            
                self.loginData.isOTPViewPresented.toggle()
                
                print("otp.sent!")
                
                completion(nil)
            }
        
            
        })
    }
    
}


extension LoginDataViewModel {
    
    func removeAllUnneeded(){
        
        self.enteredPhoneNumber = ""
        self.isCountryPickerPresented = false
        self.isOTPViewPresented = false 
    }
}


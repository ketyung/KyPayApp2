//
//  LoginViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation

class PhoneInputViewModel : NSObject, ObservableObject {
    
    
    @Published private var phoneInputData : PhoneInputData = PhoneInputData()
    
    
    var selectedCountry : Country? {
        
        get {
            
            return phoneInputData.selectedCountry
        }
        
        set(newVal){
            
            phoneInputData.selectedCountry = newVal
        }
    }
    
    
    var enteredPhoneNumber : String {
        
        get {
            
            return phoneInputData.enteredPhoneNumber
        }
        
        set(newVal){
            
            phoneInputData.enteredPhoneNumber = newVal
            
            if phoneInputData.enteredPhoneNumber.count > 12 {
                phoneInputData.enteredPhoneNumber = String(phoneInputData.enteredPhoneNumber.prefix(12))
            }
        }
    }

    
    var phoneNumberIsFirstResponder : Bool {
        
        get {
            
            return phoneInputData.phoneNumberIsFirstResponder
        }
        
        set(newVal){
            
            phoneInputData.phoneNumberIsFirstResponder = newVal
        }
    }
    
    
    var isCountryPickerPresented : Bool {
        
        get {
            
            return phoneInputData.isCountryPickerPresented
        }
        
        set(newVal){
            
            phoneInputData.isCountryPickerPresented = newVal
        }
    }
    
    
    var isOTPViewPresented : Bool {
        
        get {
            
            phoneInputData.isOTPViewPresented
        }
        
        set(newVal){
            
            phoneInputData.isOTPViewPresented = newVal
        }
    }
    
    var failedSigniningIn : Bool {
        
        get {
            
            phoneInputData.failedSigningIn
        }
        
        set(newVal){
            
            phoneInputData.failedSigningIn = newVal
        }
    }
    
    
    var signInError : Error? {
        
        get {
            
            phoneInputData.signInError
        }
        
        set(newVal){
            
            phoneInputData.signInError = newVal
        }
    }
    
}


extension PhoneInputViewModel {
    
    
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
            
                
                DispatchQueue.main.async {
          
                    self.phoneInputData.isOTPViewPresented.toggle()
                }
            
                completion(nil)
            }
        
            
        })
    }
    
}


extension PhoneInputViewModel {
    
    func removeAllUnneeded(){
        
        self.enteredPhoneNumber = ""
        self.isCountryPickerPresented = false
        self.isOTPViewPresented = false 
    }
}


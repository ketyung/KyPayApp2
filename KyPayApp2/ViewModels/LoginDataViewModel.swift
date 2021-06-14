//
//  LoginViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import FirebaseAuth

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
    }
}


extension LoginDataViewModel : AuthUIDelegate {
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    
        loginData.isOTPViewPresented = true
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        
        loginData.isOTPViewPresented = false 
    }
    
    
}

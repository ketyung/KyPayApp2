//
//  LoginViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import CountryPickerView

class LoginDataViewModel : NSObject, ObservableObject {
    
    
    @Published private var loginData : LoginData = LoginData()
    
    
    var selectedCounrty : CPVCountry? {
        
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

    
    
}

//
//  LoginData.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation


struct LoginData {
    
    var selectedCountry : Country?
    
    var enteredPhoneNumber : String = ""
    
    var phoneNumberIsFirstResponder : Bool = true
    
    var isCountryPickerPresented : Bool = false
    
    var isOTPViewPresented : Bool = false
    
    var homeTabbedViewHidden : Bool = false 
    
}


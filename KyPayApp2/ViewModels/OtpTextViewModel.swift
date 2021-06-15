//
//  OtpTextViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import Foundation

class OtpTextViewModel : NSObject, ObservableObject {
    
    @Published private var otpText = OtpText()
    
    var number1 : String  {
        
        get{
            otpText.number1
        }
        
        set(newVal){
            
            otpText.number1 = newVal
        }
    }
    
    
    var number2 : String  {
        
        get{
            otpText.number2
        }
        
        set(newVal){
            
            otpText.number2 = newVal
        }
    }
    
    
    var number3 : String  {
        
        get{
            otpText.number3
        }
        
        set(newVal){
            
            otpText.number3 = newVal
        }
    }
    
    
    
    var number4 : String  {
        
        get{
            otpText.number4
        }
        
        set(newVal){
            
            otpText.number4 = newVal
        }
    }
   
    
    var number5 : String  {
        
        get{
            otpText.number5
        }
        
        set(newVal){
            
            otpText.number5 = newVal
        }
    }
    
    var number6 : String  {
        
        get{
            otpText.number6
        }
        
        set(newVal){
            
            otpText.number6 = newVal
        }
    }
   
    
    var focusableIndex : Int {
        
        get {
            otpText.focusableIndex
        }
    }
   
}
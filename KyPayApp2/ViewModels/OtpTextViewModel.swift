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
   
    
    var text : String {
        
        get{
            
            guard let txt = otpText.text else {
                
                return "\(number1)\(number2)\(number3)\(number4)\(number5)\(number6)"
                
            }
            
            return txt
        }
        
        set(newVal){
            
            otpText.text = newVal
        
            
            if otpText.text?.count ?? 0 > 6 {
                
                otpText.text = String(otpText.text?.prefix(6) ?? "")
            }
        }
    }
    
    
    var resendEnabled : Bool {
        
        get {
            
            otpText.resendEnabled
        }
        
        set(newVal){
            
            otpText.resendEnabled = newVal
        }
    }
    
}

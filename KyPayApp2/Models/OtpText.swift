//
//  OtpText.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import Foundation

struct OtpText {
    
    
    var focusableIndex : Int = 0
    
    var number1 : String = "" {
        
        didSet{
            if number1.count > 1 {
     
                number1 = String(number1.prefix(1))
            }
            focusableIndex = 1
       
        }
    }
    
    var number2 : String = "" {
        
        didSet{
            
            if number2.count > 1 {
       
                number2 = String(number2.prefix(1))
            }
            focusableIndex = 2
       
        }
    }
    
    var number3 : String = "" {
        
        didSet{
            
            if number3.count > 1 {
      
                number3 = String(number3.prefix(1))
            }
            focusableIndex = 3
       
        }
    }
    
    
    var number4 : String = "" {
        
        didSet{
            
            if number4.count > 1 {
                
                number4 = String(number4.prefix(1))
            }
            focusableIndex = 4
      
        }
    }
    
    var number5 : String = "" {
    
        didSet{
            
            if number5.count > 1 {
     
                number5 = String(number5.prefix(1))
            }
            focusableIndex = 5
        
        }
    }
    
    
    var number6 : String = "" {
        
        didSet{
            
            if number6.count > 1 {
      
                number6 = String(number6.prefix(1))
                
            }
            focusableIndex = 0
        
        }
    }
    
    
}

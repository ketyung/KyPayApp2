//
//  Config.swift
//  KyPay
//
//  Created by Chee Ket Yung on 04/06/2021.
//

import Foundation
import RapydSDK

class Config : NSObject {
    
    private static let secretKey : String = "ecc719cf48e35bb55bd61785280f8aee0b84d8137708b8e435d98a82b2132ddafe79ca7ad5d67419"
    
    private static let accessKey : String = "C218C6ADCFE03460C9EC"
    
    private static let isSandbox : Bool = true
    
    private static var hasSetup : Bool = false
    
    class func setup(){
  
        if !hasSetup {
            
            RPDSDK.debugMode = isSandbox
            RPDSDK.setup(accessKey: accessKey, secretKey: secretKey)
            
            hasSetup = true 
        }
       
    }
}

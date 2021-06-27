//
//  PayoutMethod.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import Foundation
import RapydSDK

struct PayoutMethod {
    
    var type : String?
    
    var name : String?
    
    var category : String?
    
    var imageURL : URL?
    
    var payoutCurrencies : [String]?
    
    var senderCurrencies : [String]?
    
    mutating func setPayOutCurrencies ( _ currencies : [RPDCurrency]){
        
        payoutCurrencies = []
        currencies.forEach{
            c in
            
            payoutCurrencies?.append(c.code)
            
      //      print("payout.cuurncy::\(c.code)::\(c.name ?? "")")
        }
    }
    
    mutating func setSenderCurrencies ( _ currencies : [RPDCurrency]){
        
        senderCurrencies = []
        currencies.forEach{
            c in
            
            senderCurrencies?.append(c.code)
        }
    }
    
}


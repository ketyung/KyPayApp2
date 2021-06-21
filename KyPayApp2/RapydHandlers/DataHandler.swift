//
//  DataHandler.swift
//  KyPay
//
//  Created by Chee Ket Yung on 04/06/2021.
//

import Foundation
import RapydSDK

typealias RCountry = RapydSDK.RPDCountry
typealias Currency = RapydSDK.RPDCurrency


class DataHandler : NSObject {
    
    
    func supportedCountries( completion : (([RCountry]?)->Void)? = nil) {
        
        Config.setup()
        
        let dataManager = RPDDataManager()
        
        
        dataManager.fetchSupportedCountries(completionBlock: { (list, error) in
       
            guard let error = error else {
        
                if let completion = completion {
                    
                    completion(list)
                }
                
                return
        
            }
            
            print("err:\(error)")
        })
    
    }
    
    
    func supportedCurrencies( completion : (([Currency]?)->Void)? = nil) {
        
        
        Config.setup()
       
        let dataManager = RPDDataManager()
        dataManager.fetchSupportedCurrencies(completionBlock: { (list, error) in
            
            guard let error = error else {
        
                if let completion = completion {
                    
                    completion(list)
                }
                
                return
        
            }
            
            print("err:\(error)")
       
        })
        
    }
}


extension DataHandler {
    
    
    func supportedPaymentMethods ( countryCode : String , completion : (([RPDSupportedPaymentMethodType]?, Error?)->Void)? = nil ){
        
        Config.setup()
        
        RPDPaymentMethodManager().fetchPaymentMethod(byCountry:
        RPDCountry.country(isoAlpha2: countryCode)) { types, error in

            guard let err = error else {
                
                completion?(types,nil)
                return 
            }
            
            completion?(nil, err)
        }
    }
}
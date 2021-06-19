//
//  CurrencyManager.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import Foundation

struct CountryCurrency : Decodable{
    
    var country : String?
    
    var currency : String?
    
}

class CurrencyManager {
    
    
    private static let currencies = Bundle.main.decodeJson([CountryCurrency].self, fileName: "countryCurrency.json")
    
    static func currency(countryCode : String) -> String? {
        
        //print("\(currencies)")
       
        return currencies.filter({ countryCode.isEmpty ? true : $0.country?.contains(countryCode) ?? false  })
               .first?.currency
        
    }
}

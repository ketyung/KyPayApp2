//
//  Extensions.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import UIKit

extension Collection {
  
    subscript(safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}


extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func deg2rad() -> Double {
        return self * .pi / 180
    }
}


extension Bundle {
    
    func decodeJson <T:Decodable> (_ type : T.Type ,fileName : String,
     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) -> T {
        
         guard let url = self.url(forResource: fileName, withExtension: nil) else {
             fatalError("Failed to load file ")
         }
            
         do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
                
            let result = try decoder.decode(type, from: jsonData)
            return result
         }
         catch {
            fatalError("err:\(error)")
         }
  }
}



extension String {
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    func trim() -> String {
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

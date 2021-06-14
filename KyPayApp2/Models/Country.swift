//
//  Country.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import UIKit

struct Country : Decodable {
    

    var name : String?
    
    var code : String?

    var dialCode : String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case code
        case dialCode
    }
    
    var flag : UIImage? {
        
        return UIImage(named: "CountryPickerView.bundle/Images/\(code?.uppercased() ?? "MY")")
            
    }
    
}

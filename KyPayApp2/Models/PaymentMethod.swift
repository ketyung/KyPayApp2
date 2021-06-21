//
//  PaymentMethod.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation
import RapydSDK

struct PaymentMethod {
    
    var type : String?
    
    var country : String?
    
    var name : String?
    
    var category : String?
    
    var imageURL : URL?
    
    var paymentFlowType : String?
    
    var currencies : [String]?
}

extension PaymentMethod {
    
    var rpdPaymentMethod : RPDPaymentMethod {
        
        let rpdpm = RPDPaymentMethod()
        rpdpm.type = self.type
        return rpdpm
        
    }
}

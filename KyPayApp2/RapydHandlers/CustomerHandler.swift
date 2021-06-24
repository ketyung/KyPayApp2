//
//  CustomerHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 24/06/2021.
//

import Foundation
import RapydSDK

class CustomerHandler {
    
    
    func createCustomer(for user : User, wallet : UserWallet?, address : UserAddress?,
                        completion : ((WalletIDs?, Error?) -> Void)? = nil ) {
        
            let name = "\(user.firstName ?? "") \(user.lastName ?? "")"
            let addr = RPDAddress()
            addr.name = name
            addr.line1 = address?.line1 ?? "Line 1"
            addr.city = address?.city ?? "Kota Kinabalu"
                    
            
            let paymentMethod = RPDMinimalPaymentMethod(type: "rapyd_sbox_test", requiredFields: nil, metadata: nil)
            
            
            RPDCustomerManager().createCustomer(withName: name,
                email: user.email ?? "xxx@mail.com",phoneNumber: user.phoneNumber ?? "92929292929",
                addresses: [addr],businessVATID: nil,couponID: nil,
                invoicePrefix: "myinvoce",paymentMethod: paymentMethod,
                eWalletID: wallet?.serviceWalletId,description: nil,metadata: ["go" : "1"]){ customer , error in
                        
                guard let err = error else {
                
                    if let customer = customer {
                    
                        var w = wallet?.walletIDs
                        w?.custId = customer.ID
                        completion?(w, nil)
                    
                    }
                
                    return
                }
                
                
                completion?(nil, err)
                
            }
            
    }
}


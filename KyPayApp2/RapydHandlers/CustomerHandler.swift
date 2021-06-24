//
//  CustomerHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 24/06/2021.
//

import Foundation
import RapydSDK

class CustomerHandler {
    
    
    func createCustomer(for user : User, wallet : UserWallet?, address : UserAddress? = nil,
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

extension CustomerHandler {
    
    
    func obtainPaymentMethodID(for customerId : String, type : String,
                               completion : ((String?, Error?) -> Void)? = nil ){
        
        RPDCustomerManager().listPaymentMethods(ofCustomer: customerId, type: type,
        startingAfter: nil, endingBeforer: nil, limit: nil) { [weak self]
            paymentMethodResponse, error in
                                                            
            if let paymentMethodResponse = paymentMethodResponse, paymentMethodResponse.count > 0 {
                
                if let pid = paymentMethodResponse.first?.ID{
                    
                    completion?(pid, nil)
                    return
                }
                
                completion?(nil, error)
            }
            else {
                
                guard let self = self else { return }
                
                self.addPaymentMethod(for: customerId, type: type)
            }
        }
        
    }
    
    func addPaymentMethod(for customerId : String, type : String,
                          completion : ((String?, Error?) -> Void)? = nil ) {
    
        RPDCustomerManager().addPaymentMethod(type: type,
        customerID: customerId,requiredFields: nil,token: nil,address: nil,metadata: nil)
        {   paymentMethodData, error in
        
            guard let err = error else {
            
                
                if let paymentMethodData = paymentMethodData {
               
                    completion?(paymentMethodData.ID, nil)
                }
                
                return
            }
            
            completion?(nil, err)
            
        }
    }
    
    
}


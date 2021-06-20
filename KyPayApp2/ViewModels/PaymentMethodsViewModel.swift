//
//  PaymentMethodsViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation
import RapydSDK

class PaymentMethodsViewModel : ObservableObject{
    
    @Published private var paymentMethods : [PaymentMethod] = []
    
    var supportedPaymentMethods : [PaymentMethod] {
        
        paymentMethods
    }
}

extension PaymentMethodsViewModel {
    
    func fetchSupportedPaymentMethods(countryCode : String){
        
        if self.paymentMethods.count > 0 {
            
            return
        }
        
        DataHandler().supportedPaymentMethods(countryCode:countryCode , completion: {
           [weak self] types, err in
            
            guard let self = self else {
                
                return
            }
            
            guard let err = err else {
                
                if let types = types {
        
                    types.forEach{
                        
                        type in
                        
                        let pm = PaymentMethod(type: type.type,  name: type.name, category: type.category, imageURL: type.imageURL, paymentFlowType: type.paymentFlowType)
                        
                        self.paymentMethods.append(pm)
                    }
                    
                    self.paymentMethods.sort(by: {$0.name ?? "" < $1.name ?? ""})
                }
                return
            }
            
            print("fetching payment.methods.errr::\(err)")
        })
    }
}

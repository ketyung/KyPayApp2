//
//  PaymentMethodsViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation
import RapydSDK
import SwiftUI

class PaymentMethodsViewModel : ObservableObject{
    
    @Published private var paymentMethods : [PaymentMethod]?
    
    @Published var showLoadingIndicator : Bool = false
    
    @Published var selectedPaymentMethod : PaymentMethod?
    
    var supportedPaymentMethods : [PaymentMethod] {
        
        paymentMethods ?? []
    }
}

extension PaymentMethodsViewModel {
    
    func fetchSupportedPaymentMethods(countryCode : String){
        
        if self.paymentMethods != nil  {
            
            return
        }
        
        self.paymentMethods = []
        
        withAnimation{
       
            self.showLoadingIndicator = true
        }
        
       
        
        DataHandler().supportedPaymentMethods(countryCode:countryCode , completion: {
           [weak self] types, err in
            
            guard let self = self else {
                
                return
            }
            
            
            guard let err = err else {
                
                // filter for banks only, exclude other e-Wallets
                if let types = types?.filter({$0.category == "bank_redirect"}) {
        
                    DispatchQueue.main.async {
                  
                        types.forEach{
                            
                            type in
                            
                            let pm = PaymentMethod(type: type.type,  name: type.name, category: type.category, imageURL: type.imageURL, paymentFlowType: type.paymentFlowType)
                            
                            self.paymentMethods?.append(pm)
                     
                            
                        }
                        
                        self.paymentMethods?.sort(by: {$0.name ?? "" < $1.name ?? ""})
                        
                        withAnimation{
                
                            self.showLoadingIndicator = false
                        }
                    }
                  
                }
                return
            }
            
            print("fetching payment.methods.errr::\(err)")
        })
    }
}

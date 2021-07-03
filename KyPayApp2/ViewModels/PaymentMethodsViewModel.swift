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
    
    private lazy var cachedPMDs = CPMDS()
    
    var supportedPaymentMethods : [PaymentMethod] {
        
        paymentMethods ?? []
    }
}

extension PaymentMethodsViewModel {
    
    
    private func fetchFromCachedDb(countryCode : String) -> [PaymentMethod]{
        
        var pms : [PaymentMethod] = []
        
      //  print("total.saved.pms::\(cachedPMDs.total())")
        
        if let cpms = cachedPMDs.all(by :countryCode) {
            
            cpms.forEach{
                
                cpm in
                
                pms.append(PaymentMethod(type: cpm.type, country: cpm.country, name: cpm.name, category: cpm.category, imageURL: URL(string: cpm.imageURL ?? ""), paymentFlowType: cpm.paymentFlowType, currencies: nil))
            }
        }
        
        return pms
    
    }
}


    
extension PaymentMethodsViewModel {
    
    func fetchSupportedPaymentMethods(countryCode : String){
        
        if self.paymentMethods != nil  {
            
            return
        }
       
        //CPMDS().removeAll()
      
        
        self.paymentMethods = self.fetchFromCachedDb(countryCode: countryCode)
        
        if (self.paymentMethods?.count ?? 0) > 0 {
            
            self.paymentMethods?.sort(by: {$0.name ?? "" < $1.name ?? ""})
           
            return
        }
        
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
                if let types = types?.filter({$0.category == "bank_redirect" || $0.category == "bank_transfer"} )
                {
        
                    DispatchQueue.main.async {
                  
                        types.forEach{
                            
                            type in
                            
                            
                            print("type::\(type.category)")
                            let pm = PaymentMethod(type: type.type,  country : countryCode, name: type.name, category: type.category, imageURL: type.imageURL, paymentFlowType: type.paymentFlowType)
                            
                            self.paymentMethods?.append(pm)
                            
                            DispatchQueue.main.async {
                            
                                self.cachedPMDs.savePaymentMethod(by: pm)
                                
                            }
                            
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

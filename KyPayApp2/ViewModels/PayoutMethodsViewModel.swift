//
//  PayoutMethodsViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import Foundation

class PayoutMethodsViewModel : ObservableObject {
    
    @Published var payoutMethods : [PayoutMethod]?

    @Published var showLoadingIndicator : Bool = false
    
    @Published var selectedPayoutMethod : PayoutMethod?
   
    var supportedPayoutMethods : [PayoutMethod] {
        
        payoutMethods ?? []
    }
    
    private lazy var dataHandler = DataHandler()
    
}

extension PayoutMethodsViewModel {
    
    
    func fetchSupportedPayoutMethods ( countryCode : String, currency : String ){
        
        if self.payoutMethods != nil {
            
            return
        }
        
        self.payoutMethods = []
        
        self.showLoadingIndicator = true
        
        dataHandler.supportedPayoutMethods(countryCode: countryCode, currency: currency, completion: { [weak self]
            payoutMethodTypes , err in
            
            guard let self = self else { return }
            
            guard let err = err else {
                
                if let payoutMethodTypes = payoutMethodTypes {
            
                    payoutMethodTypes.forEach{ pmt in
                        
                        var pm = PayoutMethod(type: pmt.type, name: pmt.name, category: pmt.category.rawValue, imageURL: pmt.imageURL)
                        
                        if let pocurrs = pmt.payoutCurrencies {
                            pm.setPayOutCurrencies(pocurrs)
                        }
                        if let sdcurrs = pmt.senderCurrencies {
                            pm.setSenderCurrencies(sdcurrs)
                        }
                        self.payoutMethods?.append(pm)
                        
                    }
                }
                self.showLoadingIndicator = false
                return
                
            }
            
            self.showLoadingIndicator = false 
            print("fetching payout.methods.errr::\(err)")
     
        })
    }
}

//
//  TxHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 28/06/2021.
//

import Foundation
import RapydSDK

class TxHandler {
    
    
    
    func transfer(to phoneNumber : String, amount : Double, currency :String, completion : ((String?,Error?)->Void)? = nil ){
        
        Config.setup()
        
        let transferRequest:RPDTransferRequest = RPDTransferRequest()
        transferRequest.currency = RPDCurrency.currency(with: currency)
        transferRequest.amount = "\(amount)"
        transferRequest.destination = phoneNumber
        
        let transferManager = RPDAccountsManager()
        transferManager.transfer(toUserWithTransferRequest: transferRequest, completionBlock: { details, error in
            // Enter your code here.
            
            guard let err = error else {
          
                if let id = details?.id {
                    
                    transferManager.transfer(replyWithTransferId: id, status: .accept, completionBlock: {details, error in
                    
                        guard let err = error else {
                       
                            completion?(details?.id , nil)
                    
                            return
                        }
                        
                        completion?(nil, err)
                       
                    })
                }
                else {
                    
                    completion?(nil, CustomError(errorText: "The user might NOT have a wallet!"))
                }
                
                return
            }
            
            
            completion?(nil, err)
            
        })
        
    }
    
}


extension TxHandler {
    
    
    func transfer(for cartViewModel : CartViewModel,  completion : (([SellerOrder]?,Error?)->Void)? = nil){
        
        var currency = Common.defaultCurrency
        
        let itemsBySeller = cartViewModel.itemsBySeller
        
        var orders : [SellerOrder] = []
        
        itemsBySeller.keys.forEach{ seller in
            
            let phoneNumber = seller.phoneNumber ?? ""
            
            let subTotal = cartViewModel.subTotalAmountBy(seller: seller , currency: &currency)
            
            self.transfer(to: phoneNumber, amount: subTotal, currency: currency, completion: {
                
                id , err in
            
                guard let err = err else {
          
                    
                    let so = SellerOrder(seller: seller,
                    items: itemsBySeller[seller], total: subTotal, servicePaymentId: id)
                     
                    orders.append(so)
                    
                    return
                }
                
                completion?(nil, err)
                
                
            })
        
        }
        
        completion?(orders, nil)
    }
}

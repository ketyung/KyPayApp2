//
//  TxHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 28/06/2021.
//

import Foundation
import RapydSDK

class TxHandler {
    
    
   // private var onFinishCompletion : ((Order?) -> Void)?
    
    
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
    
    
    
    
    func transfer(for cartViewModel : CartViewModel, by user : User,
                  wallertRefId : String,
                  completion : ((Order?)->Void)? = nil){
        
     //   self.onFinishCompletion = completion
        
        var currency = Common.defaultCurrency
        
        let itemsBySeller = cartViewModel.itemsBySeller
        
        var order = Order()
        order.total = cartViewModel.totalAmount()
        order.currency = currency
        order.status = .new
        order.uid = user.id
        order.walletRefId = wallertRefId
        
        order.paymentMethod = "kypay_wallet_transfer"
    
        
        itemsBySeller.keys.forEach{ seller in
            
            let subTotal = cartViewModel.subTotalAmountBy(seller: seller , currency: &currency)
            
            let items = itemsBySeller[seller]
            
            self.transfer(for: seller, currency: currency, subTotal: subTotal, items: items, completion: { so in
                
                if let so = so {
        
                    order.add(order: so)
                
                    print("c.orders.count::\(order.orders?.count ?? 0)")
                  
                    if order.orders?.count == itemsBySeller.count {
                        
                        completion?(order)
                    }
                    
                  
                }
            })
        }
        
        
        
    }
    
    
    private func transfer(for seller : Seller, currency : String, subTotal : Double,
                          items : [CartItem]?, completion: ((SellerOrder?)->Void)? = nil ) {
        
        let phoneNumber = seller.phoneNumber ?? ""
        
        
        var so = SellerOrder(seller: seller, items: items, total: subTotal)
        
        
        self.transfer(to: phoneNumber, amount: subTotal, currency: currency, completion: {
            
            id , err in
        
            guard let _ = err else {
      
                so.servicePaymentId = id
                 
                completion?(so)
                return
            }
            
            //completion?(nil, err)
            
            completion?(nil)
            
        })
    }
    
}

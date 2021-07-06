//
//  Payment.swift
//  KyPay
//
//  Created by Chee Ket Yung on 04/06/2021.
//

import Foundation
import RapydSDK


class PaymentHandler : NSObject {
    
    
    func pay( for cartViewModel : CartViewModel, paymentMethod : String ){
        
        
        var currency = Common.defaultCurrency
       
        let itemsBySeller = cartViewModel.itemsBySeller
        
        var custIds : [String] = []
        var amounts : [Double] = []
        
        
        itemsBySeller.keys.forEach{ seller in
        
            let subTotal = cartViewModel.subTotalAmountBy(seller: seller , currency: &currency)
            amounts.append(subTotal)
            custIds.append(seller.serviceCustId ?? "")
            
        }
        
        
        
     
    }
    
    
    private func add (total : Double, subTotals : [Double],
    eWalletIDs : [String], currency : String, type : String,
    paymentMethodID : String, customerId : String,
    completion : ((PaymentData?, Error?)->Void)? = nil ){
        
        RPDPaymentMethodManager().fetchPaymentMethodRequiredFields(type: type) { [weak self]
            pmfields, error in
            
            if error != nil {
                completion?(nil, error)
                return
            }
            
            guard let self = self else { return }
        
            
            if var pmfields = pmfields {
            
                WalletHandler.setFieldsForOnlineBanking(&pmfields)
        
                let currentUser = RPDUser.currentUser()
                
                
                var ewallets : [RPDEWallet] = []
                
                for i in 0 ..< eWalletIDs.count {
                    
                    let walletId = eWalletIDs[i]
                    let subTotal = subTotals[i]
                
                    ewallets.append( RPDEWallet(ID: walletId, paymentValue: Decimal(subTotal), paymentType: RPDEWallet.EWalletPaymentType.amount) )
                    
                }
                
                
                let pmMgr = RPDPaymentManager()
                
                    
                pmMgr.createPayment(amount: Decimal(total),
                    currency: RPDCurrency.currency(with: currency),
                    paymentMethodRequiredFields:pmfields,paymentMethodID: paymentMethodID ,
                    eWallets: ewallets,
                    completePaymentURL: WalletHandler.completionURL,errorPaymentURL: WalletHandler.errorURL,
                    description: nil,expirationAt: nil,merchantReferenceID: nil,requestedCurrency: nil,isCapture:nil,
                    statementDescriptor: nil,address: nil,customerID: customerId,receiptEmail: currentUser?.email ,
                    showIntermediateReturnPage: nil,isEscrow: nil,releaseEscrowDays: nil,paymentFees: nil,
                    metadata:["game": "uncharted"], completionBlock: { payment, err in
                    
                        guard let err = err else {
                    
                         //   print("payment?.completePaymentURL::\(String(describing: payment?.completePaymentURL))")
                            
                           var pms = PaymentData()
                           pms.amount = Double(truncating: (payment?.amount ?? 0) as NSNumber)
                           pms.curreny = payment?.currency?.code ?? ""
                           pms.dateCreated = payment?.createdAt
                           pms.status = .created
                           pms.redirectURL = payment?.redirectURL
                           pms.id = payment?.ID
                        
                           completion?(pms, nil)
                           return
                        }
                        
                        completion?(nil, err)
                    
                })
            }
         
        }
    }
    
    
    
}

extension PayoutHandler {
    
    func pay(to walletID : String, amount : Decimal){
        
        let currency = RPDCurrency()
        
        let ewallet1 = RPDEWallet(ID: walletID, paymentValue: 50.00, paymentType:.amount )
        
        let rpdPaymentManager = RPDPaymentManager()
        
        rpdPaymentManager.createPayment(amount: amount, currency: currency, paymentMethodRequiredFields: nil, paymentMethodID: nil, eWallets: [ewallet1], completionBlock: { status ,error in
            
            print("err::\(String(describing: error))")
        })
    }
    
    
    func listPayments(limit : Int = 20){
        
        RPDPaymentManager().listPayments(limit:UInt(limit), startingAfter: nil, endingBefore: nil) { payments, error in
           
           if let payments = payments {
               print("\(payments.count)")
            
           }
       }
    }
}


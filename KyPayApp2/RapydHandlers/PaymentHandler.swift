//
//  Payment.swift
//  KyPay
//
//  Created by Chee Ket Yung on 04/06/2021.
//

import Foundation
import RapydSDK


class PaymentHandler : NSObject {
    
    private lazy var customerHandler = CustomerHandler()
   
    
    func pay( for cartViewModel : CartViewModel, paymentMethod : String,
              customerId : String, completion : ((String?, Error?)->Void)? = nil ){
        
        Config.setup()
        
        var currency = Common.defaultCurrency
       
        let itemsBySeller = cartViewModel.itemsBySeller
        
        var walletIds : [String] = []
        var subTotals : [Double] = []
        
        
        itemsBySeller.keys.forEach{ seller in
        
            let subTotal = cartViewModel.subTotalAmountBy(seller: seller , currency: &currency)
            subTotals.append(subTotal)
            walletIds.append(seller.serviceWalletId ?? "")
            
        }
        
        self.customerHandler.obtainPaymentMethodID(for: customerId, type: paymentMethod, completion: {
            [weak self] paymentMethodID, error in
            
            if error != nil {
                completion?(nil, error)
                return
            }
            
            guard let self = self else { return }
        
            
            if let paymentMethodID = paymentMethodID {
           
                self.add(total: cartViewModel.totalAmount(), subTotals: subTotals, eWalletIDs: walletIds,
                currency: currency, type: paymentMethod, paymentMethodID: paymentMethodID, customerId: "")
            
            }
            else {
                
                print("Error!!!...unable.2.obtain::paymentMethodID")
            }
            
        })
        
        
        
    
    }
    
    
    private func add (total : Double, subTotals : [Double],
    eWalletIDs : [String], currency : String, type : String,
    paymentMethodID : String, customerId : String,
    completion : ((PaymentData?, Error?)->Void)? = nil ){
        
        RPDPaymentMethodManager().fetchPaymentMethodRequiredFields(type: type) {
            pmfields, error in
            
            if error != nil {
                completion?(nil, error)
                return
            }
            
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

    
    func listPayments(limit : Int = 20){
        
        RPDPaymentManager().listPayments(limit:UInt(limit), startingAfter: nil, endingBefore: nil) { payments, error in
           
           if let payments = payments {
               print("\(payments.count)")
            
           }
       }
    }
}


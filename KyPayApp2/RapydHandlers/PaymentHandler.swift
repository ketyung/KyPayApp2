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


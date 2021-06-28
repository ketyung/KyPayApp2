//
//  TxHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 28/06/2021.
//

import Foundation
import RapydSDK

class TxHandler {
    
    
    
    func transfer(phoneNumber : String, amount : Double, currency :String){
        
        Config.setup()

        let transferRequest:RPDTransferRequest = RPDTransferRequest()
        transferRequest.currency = RPDCurrency.currency(with: currency)
        transferRequest.amount = "\(amount)"
        transferRequest.destination = phoneNumber
        
        let transferManager = RPDAccountsManager()
        transferManager.transfer(toUserWithTransferRequest: transferRequest, completionBlock: { details, error in
            // Enter your code here.
            
            print("tx.req.details::\(details?.id ?? "")::\(details?.currency.code ?? "xxx"):\(details?.destinationPhoneNumber ?? "")")
            
        })
        
    }
    
}

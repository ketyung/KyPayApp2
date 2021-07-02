//
//  PayoutHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import Foundation
import RapydSDK

class PayoutHandler : NSObject {
    
    
    func issuePayout(from user : User, for biller : Biller){
        
        self.obtainBeneficiaryOf(biller: biller, completion: { p in
        
            
        
        })
    }
    
}

extension PayoutHandler {
    
    private func obtainBeneficiaryOf(biller : Biller, completion : ((RPDPayoutTransferBeneficiaryPartaker?)->Void)? = nil ){
        
        if let bid = biller.serviceBid {
            
            RPDPayoutManager().retrieveBeneficiary(forID: bid) { b, error in
            
                guard let err = error else {
                    
                    completion?(b)
                    
                    return
                }
                
                print("obtainining.beneficiary.for.biller.error:\(err)")
            }
        }
    }
    
}


extension PayoutHandler {
    
    
    func getPayoutRequiredFields ( for user : User, biller : Biller, amount : Double, payoutCurrency : String) {
        
        let senderCountry = user.countryCode ?? "MY"
        let senderCurrency = CurrencyManager.currency(countryCode: senderCountry) ?? "MYR"
        
        
        RPDPayoutManager().getPayoutRequiredFields(payoutMethodType: biller.payoutMethod ?? "",
                              payoutAmount: Decimal(amount), payoutCurrency: RPDCurrency.currency(with: payoutCurrency),
                              beneficiaryCountry: RPDCountry.country(isoAlpha2: user.countryCode ?? "MY"),
                              beneficiaryEntityType: .individual,
                              senderCountry: RPDCountry.country(isoAlpha2: senderCountry),
                              senderCurrency: RPDCurrency.currency(with: senderCurrency),
                              senderEntityType: .individual) { payoutRequiredFieldsDetails, error in
                                                            
                if let payoutRequiredFieldsDetails = payoutRequiredFieldsDetails {
                                                                
                    if var senderRequiredFields = payoutRequiredFieldsDetails.senderRequiredFields, var beneficiaryRequiredFields = payoutRequiredFieldsDetails.beneficiaryRequiredFields {
                                        
                        self.set(beneficiaryRequiredFields: &beneficiaryRequiredFields, user: user)
                        self.set(senderRequiredFields: &senderRequiredFields, user: user)
                    }
                }
        }
    }
}

            
            
extension PayoutHandler {
                
    private func set(beneficiaryRequiredFields : inout [RPDPayoutRequiredField], user : User){
        
        beneficiaryRequiredFields.forEach {
                                                        
            switch $0.name {
                                
                 case "firstName":
                    $0.value = user.firstName
                                
                 case "lastName":
                    $0.value = user.lastName
                                
                 case "address":
                       $0.value = "123 Any street"
                                
                 case "phone_number":
                    $0.value = user.phoneNumber
                                
                 case "state":
                       $0.value = "usa"
                                
                 case "city":
                       $0.value = "c"
                                
                 case "identification_type":
                       $0.value = "64564645634"
                                
                 case "identification_value":
                       $0.value = "565656"
                                
                  default:
                       break
            }
        }
    }
    
    
    private func set(senderRequiredFields : inout [RPDPayoutRequiredField], user : User) {
        
        senderRequiredFields.forEach {
                         
             switch $0.name {
                                 
                 case "firstName":
                    $0.value = user.firstName
                                 
                 case "lastName":
                    $0.value = user.lastName
                                 
                 case "city":
                       $0.value = "sd"
                                 
                 case "state":
                       $0.value = "sd"
                                 
                 case "phone_number":
                       $0.value = user.phoneNumber
                                 
                  default:
                        break
            }
        }
    }
}
            

extension PayoutHandler {
    
    func createSender(for user: User, currency : String, senderRequiredFields : [RPDPayoutRequiredField]){
        
        
        RPDPayoutManager().createSender(country: RPDCountry.country(isoAlpha2: user.countryCode ?? "MY"),                                 currency: RPDCurrency.currency(with: currency),entityType: RPDEntityHolderType.individual,                                      senderRequiredFields: senderRequiredFields,firstName: user.firstName, lastName: user.lastName,
            companyName: "abc",identifierType: "IC", identifierValue: "99299393939",
            
            completionBlock: { sender, error in
                if let sender = sender {
                    
                    print("sender.id::\(sender.ID)")
                }
        })

    }
}

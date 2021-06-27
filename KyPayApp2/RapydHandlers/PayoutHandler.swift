//
//  PayoutHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import Foundation
import RapydSDK

class PayoutHandler : NSObject {
    
    
    func issuePayoutFor(wallet : UserWallet, user : User, payoutMethod : PayoutMethod){
        
        
        
    }
    
}


extension PayoutHandler {
    
    
    func getPayoutRequiredFields ( for user : User, wallet : UserWallet, payoutMethod : PayoutMethod,
    amount : Double, payoutCurrency : String, senderCurrency : String) {
        
        
        RPDPayoutManager().getPayoutRequiredFields(payoutMethodType: payoutMethod.type ?? "",payoutAmount: Decimal(amount),
                              payoutCurrency: RPDCurrency.currency(with: payoutCurrency),
                              beneficiaryCountry: RPDCountry.country(isoAlpha2: user.countryCode ?? "MY"),
                              beneficiaryEntityType: .individual,
                              senderCountry: RPDCountry.country(isoAlpha2: "MX"),
                              senderCurrency: RPDCurrency.currency(with: "MXN"),
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
            companyName: "abc",identifierType: "IC", identifierValue: "99299393939", completionBlock: { sender, error in
                if let sender = sender {
                    
                    print("sender.id::\(sender.ID)")
                }
        })

    }
}

extension PayoutHandler {
    
    
    
    func createBenefiary(){
        
        
    }
}

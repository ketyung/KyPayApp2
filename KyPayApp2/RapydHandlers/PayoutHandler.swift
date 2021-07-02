//
//  PayoutHandler.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import Foundation
import RapydSDK

class PayoutHandler : NSObject {
    
    
    func issuePayout(from user : User, walletSenderID : String? = nil ,
                     for biller : Biller, amount : Double, number : String,
                     completion: ((_ payoutID : String?,_ senderID : String?, _ error : Error?)->Void)? = nil ){
        
        Config.setup()
        
        let senderCountry = user.countryCode ?? "MY"
        let senderCurrency = CurrencyManager.currency(countryCode: senderCountry) ?? "MYR"
       
        let billerCountry = biller.country ?? "MY"
        let billerCurrency = CurrencyManager.currency(countryCode: billerCountry) ?? "MYR"
      
        if let senderID = walletSenderID {
            
            
            self.createPayout(for: user, biller: biller, senderID: senderID, amount: amount, number: number, senderCountry: senderCountry, senderCurrency: senderCurrency, billerCountry: billerCountry, billerCurrency: billerCurrency,
                              completion: {
                payoutId, err in
                                
                completion?(payoutId, nil, err)
            })
        }
        else {
         
            
            //self.getPayoutRequiredFields(for: user, biller: biller, amount: amount, senderCountry: senderCountry,
              //  senderCurrency: senderCurrency, billerCountry: billerCountry, billerCurrency: billerCurrency, completion: {
               // [weak self] senderRequiredFields, beneficiaryRequiredFields in
     
            var senderRequiredFields : [RPDPayoutRequiredField] = []
            
            self.set(senderRequiredFields: &senderRequiredFields, user: user)
            
            self.createSender(for: user, currency: senderCurrency,
            senderRequiredFields: senderRequiredFields ,completion: { [weak self ] senderID in
                      
                guard let self = self else {return}
                
                if let senderID = senderID {
                    
                    self.createPayout(for: user, biller: biller, senderID: senderID, amount: amount, number: number, senderCountry: senderCountry, senderCurrency: senderCurrency, billerCountry: billerCountry, billerCurrency: billerCurrency,completion: { payoutId, err in
                                        
                        completion?(payoutId, senderID, err)
                    })
                }
                                
            })
             
           // })
            
        }
    }
    
}

extension PayoutHandler {
    
    
    private func createPayout(for user : User, biller : Biller, senderID : String,  amount : Double,
    number : String, senderCountry : String, senderCurrency : String, billerCountry : String,
    billerCurrency : String, completion: ((String?, Error?)->Void)? = nil){
        
        self.getPayoutRequiredFields(for: user, biller: biller, amount: amount, senderCountry: senderCountry,
            senderCurrency: senderCurrency, billerCountry: billerCountry, billerCurrency: billerCurrency, completion: {
            [weak self] senderRequiredFields, beneficiaryRequiredFields in
                
                guard let self = self else { return}
            
                self.createPayout(for: biller, amount: amount, senderID: senderID, senderCurrency: senderCurrency, senderCountry: senderCountry, number: number, beneficiaryRequiredFields: beneficiaryRequiredFields ?? [], senderRequiredFields: senderRequiredFields ?? [], completion: { id, err in
                    
                    completion?(id, err)
                    
                })
        })
        
    }
    
    
    private func createPayout(for biller : Biller, amount : Double, senderID : String,
        senderCurrency : String, senderCountry : String, number : String,
        beneficiaryRequiredFields : [RPDPayoutRequiredField],senderRequiredFields : [RPDPayoutRequiredField], completion:((String?, Error?)-> Void)? = nil ){
        
        let payoutCurrency = RPDCurrency.currency(with: CurrencyManager.currency(countryCode:  biller.country ?? "MY") ?? "MYR")
        let beneficiaryCountry = RPDCountry.country(isoAlpha2: biller.country ?? "MY")
        
      //  print("::\(biller.country ?? "")::beneficiaryCountry::\(beneficiaryCountry.isoAlpha2)::\(beneficiaryCountry.phoneCode ?? "")")
        
        RPDPayoutManager().createPayout(payoutMethodType: biller.payoutMethod ?? "", payoutAmount: Decimal(amount), payoutCurrency: payoutCurrency, beneficiary: beneficiaryRequiredFields, beneficiaryID: biller.serviceBid ?? "",
            beneficiaryCountry: beneficiaryCountry, beneficiaryEntityType: .company,
            sender: senderRequiredFields, senderID: senderID, senderCountry: RPDCountry.country(isoAlpha2: senderCountry), senderCurrency: RPDCurrency.currency(with: senderCurrency), senderEntityType: .individual,
            description:"\(PH.payBillPrefix)\(number)" , metadata: nil, merchantReferenceID: nil, confirmAutomatically: true, expiration: nil, identifierType: PH.temp_id_type, identifierValue: PH.temp_id_value, completionBlock: {
                
                payout, err in
            
                completion?(payout?.ID, err)
                
            
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
    
    
    func getPayoutRequiredFields ( for user : User, biller : Biller, amount : Double, senderCountry : String, senderCurrency : String, billerCountry : String, billerCurrency : String,
            completion : ((_ senderRequiredFields : [RPDPayoutRequiredField]?, _ beneficiaryRequiredFields : [RPDPayoutRequiredField]?)->Void)? = nil) {
        
        
        RPDPayoutManager().getPayoutRequiredFields(payoutMethodType: biller.payoutMethod ?? "",
          payoutAmount: Decimal(amount),
          payoutCurrency: RPDCurrency.currency(with: billerCurrency),
          beneficiaryCountry: RPDCountry.country(isoAlpha2: billerCountry),
          beneficiaryEntityType: .individual,
          senderCountry: RPDCountry.country(isoAlpha2: senderCountry),
          senderCurrency: RPDCurrency.currency(with: senderCurrency),
          senderEntityType: .individual) { payoutRequiredFieldsDetails, error in
                                        
            guard let error = error else {
             
                if let payoutRequiredFieldsDetails = payoutRequiredFieldsDetails {
                                                                
                    if var senderRequiredFields = payoutRequiredFieldsDetails.senderRequiredFields,
                       var beneficiaryRequiredFields = payoutRequiredFieldsDetails.beneficiaryRequiredFields {
                       
                        print("sender.rq.fields.fr.obtained::\(senderRequiredFields)")
                        print("benefi.rq.fields.fr.obtained::\(beneficiaryRequiredFields)")
                       
                        self.set(beneficiaryRequiredFields: &beneficiaryRequiredFields, biller: biller)
                        self.set(senderRequiredFields: &senderRequiredFields, user: user)
                        
                        completion?(senderRequiredFields, beneficiaryRequiredFields)
                        return
                    }
                }
                
                
                var senderRequiredFields : [RPDPayoutRequiredField] = []
                var beneficiaryRequiredFields : [RPDPayoutRequiredField] = []
                self.set(senderRequiredFields: &senderRequiredFields, user: user)
                self.set(beneficiaryRequiredFields: &beneficiaryRequiredFields, biller:  biller)
            
                completion?(senderRequiredFields, beneficiaryRequiredFields)
              
                return
            }
            
            print("error.obtaining.required.fields::\(String(describing: error))")
            
            completion?(nil,nil)
            
        }
    }
}

            
            
extension PayoutHandler {
                
    private func set(beneficiaryRequiredFields : inout [RPDPayoutRequiredField], biller : Biller){
        
        beneficiaryRequiredFields.forEach {
                                                        
            switch $0.name {
               
                case "address":
                       $0.value = "123 Any street"
                                
                                
                 case "state":
                       $0.value = "usa"
                                
                 case "city":
                       $0.value = "c"
                                
                    
                                
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
                               
                case "identification_type":
                        $0.value = PH.temp_id_type
                            
                // will need to update this later for future use
                // real IC number from user
                 case "identification_value":
                        $0.value = PH.temp_id_value
                
                  default:
                        break
            }
        }
    }
}
            

typealias PH = PayoutHandler

extension PayoutHandler {
    
    static let payBillPrefix : String = "PayBill:"
    
    private static let temp_id_type : String = "ic_number"
    
    private static let temp_id_value : String = "770120-12-5677"
    
    private static let temp_company_name : String = "TechChee.com"
    
    func createSender(for user: User, currency : String, senderRequiredFields : [RPDPayoutRequiredField]
        , completion : ((String?)->Void)? = nil ){
        
        
        RPDPayoutManager().createSender(country: RPDCountry.country(isoAlpha2: user.countryCode ?? "MY"),                       currency: RPDCurrency.currency(with: currency),entityType: RPDEntityHolderType.individual,                                senderRequiredFields: senderRequiredFields,firstName: user.firstName, lastName: user.lastName,
                companyName: PH.temp_company_name,identifierType: PH.temp_id_type,identifierValue: PH.temp_id_value,
            
            completionBlock: { sender, error in
                if let sender = sender {
                    
                 //   print("obtained.sender.id::\(sender.ID)")
                    
                    completion?(sender.ID)
                    return
                }
                
                print("obtaining.sender.id::.error::\(String(describing: error))")
        })

    }
    
    

    
}

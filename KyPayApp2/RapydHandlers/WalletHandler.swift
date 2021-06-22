//
//  WalletHandler.swift
//  KyPay
//
//  Created by Chee Ket Yung on 04/06/2021.
//

import Foundation
import RapydSDK

typealias RWalletType = RapydSDK.RPDWalletType
typealias Gender = RapydSDK.RPDGenderType
typealias ResidenceType = RapydSDK.RPDResidenceType
typealias MaritalStatus = RapydSDK.RPDMaritalStatusType

class WalletHandler : NSObject {
    
    private let genericMetaData =  ["game": "uncharted"]
    

    func createWallet(for user : User, wallet : UserWallet,
        address : UserAddress? = nil ,
        completion : ((Error?)->Void)? = nil ) {
        
        Config.setup()
        
        let countryCode = user.countryCode ?? "MY"
        
        let addr = RPDAddress()
        addr.name = address?.id ?? "a1"
        addr.line1 = address?.line1 ?? "line 1"
        addr.country = RPDCountry.country(isoAlpha2: countryCode)
        addr.city = address?.city ?? "City"
        
        
        let contact = RPDEWalletContactRequestBuilder(contactType: .personal,
        firstName: user.firstName ?? "", lastName: user.lastName ?? "", email: user.email ?? "",
        phoneNumber: user.phoneNumber ?? "", businessDetails: nil,
        dateOfBirth: user.dob ,
        middleName: "mn",
        secondLastName: "sln",
        identificationNumber: "100",
        gender: RPDGenderType.male,
        residence: RPDResidenceType.own,
        maritalStatus: .none,
        identificationType: "PA",
        address: addr,
        country: RCountry.country(isoAlpha2: countryCode) )
        
        
        let usersManager = RPDUsersManager()
        
        usersManager.createUser(phoneNumber: user.phoneNumber ?? "",
            eWalletType: self.toRWalletType(wallet),
            firstName: user.firstName ?? "", lastName: user.lastName ?? "", email: user.email ?? "",
            eWalletReferenceID: wallet.refIdForService ?? "", contact: contact, metadata: genericMetaData, completionBlock:{
            
            _, error in
            
            if let error = error {
        
                completion?(error )
                return
            }
        
            completion?(nil)
            
        })
        
    }
    
    
    
    func deleteWallet(){
        
        let userManager:RPDUsersManager = RPDUsersManager()
        userManager.deleteUser(completionBlock: { (error) in
           
            guard let err = error else {
                
                return
            }
            
            print("deleting.wallet.error:\(err)")
        })
    }
    
    private func toRWalletType ( _ wallet : UserWallet) -> RWalletType{
        
        if wallet.type == .personal {
            
            return RWalletType.person
        }
        else if ( wallet.type == .business ){
            
            return RWalletType.company
        }
        
        return RWalletType.person
        
    }
    
}

extension WalletHandler {
    
    
    func detachWallet(){
        
        Config.setup()
       
        RPDUser.detachUser()
    }
    
    func attachWallet(user : User, wallet : UserWallet, completion : ((String?, Error?)->Void)? = nil ){
        
        Config.setup()
       
        let ruser : RPDUser = RPDUser()
        ruser.phoneNumber = user.phoneNumber ?? ""
        ruser.email = user.email ?? ""
        ruser.eWalletReferenceID = wallet.refId ?? ""
    
                    
        let userManager:RPDUsersManager = RPDUsersManager()
        userManager.attachUser(ruser, completionBlock: { _, error in
          // Enter your code here.
            
            guard let err = error else {
                
                return
            }
            
            
            completion?(nil, err)
            
        })
    }
    
    func currentWallet(attachIfNotPresent user : User, wallet : UserWallet, completion : ((String?, Error?)->Void)? = nil,
    toPrint : Bool = false ){
        
        Config.setup()
       
        if let ruser = RPDUser.currentUser() {
  
            if toPrint {
                
                print("RPD.user::.id::\(ruser.id ?? "")::\(ruser.firstName ?? "") \(ruser.lastName ?? "") : wallet.refId::\(ruser.eWalletReferenceID ?? "xxx") ::balance::")
            }
            
            completion?(ruser.eWalletReferenceID, nil)
            
        }
        else {
            
            self.attachWallet(user: user, wallet: wallet, completion: completion)
        }
    }
}

extension WalletHandler {
    
    
    func add(amount : Double, currency : String, paymentMethod : PaymentMethod,
               completion : ((PaymentSuccess?, Error?)->Void)? = nil ){
        
        Config.setup()
        
        let pm = paymentMethod.rpdPaymentMethod
        
        //print("using.paymentMethod.type::\(pm.type ?? "xxxx")")
        
        RPDPaymentMethodManager().fetchPaymentMethodRequiredFields(type: pm.type ?? "") { fields, error in
            
            if let err = error {
                
                print("fetchPaymentMethodRequiredFields.err::\(err)")
                return
            }
            
            let ewallet1 = RPDEWallet(ID: RPDUser.currentUser()?.id ?? "xxx",
            paymentValue: Decimal(amount), paymentType: RPDEWallet.EWalletPaymentType.amount)
            
            
            let pmMgr = RPDPaymentManager()
            pmMgr.createPayment(amount: Decimal(amount), currency:RPDCurrency.currency(with: currency),
            paymentMethodRequiredFields: fields, paymentMethodID: pm.type, eWallets: [ewallet1], completionBlock: {
                
                payment, err in
                
                guard let err = err else {
                    
                   var pms = PaymentSuccess()
                   pms.amount = Double(truncating: (payment?.amount ?? 0) as NSNumber)
                   pms.curreny = payment?.currency?.code ?? ""
                   pms.dateCreated = payment?.createdAt
                   
                   completion?(pms, nil)
                   return
                }
                
                completion?(nil, err)
               
                print("error.making.payment::\(err)")
                
                
            })
          
        }
       
    }
}

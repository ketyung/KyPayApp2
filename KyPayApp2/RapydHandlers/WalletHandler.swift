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


struct WalletIDs {
    
    var walletId : String?
    
    var addrId : String?
    
    var contactId : String?
    
    var refId : String?
    
    
    fileprivate init(from rpdUser : RPDUser){
        
        self.walletId = rpdUser.id
        self.addrId = rpdUser.contacts?.dataList?.first?.address?.ID
        self.contactId = rpdUser.contacts?.dataList?.first?.ID
        self.refId = rpdUser.eWalletReferenceID
    }
}

class WalletHandler : NSObject {
    
    private let genericMetaData =  ["game": "uncharted"]
    

    func createWallet(for user : User, wallet : UserWallet,
        address : UserAddress? = nil ,completion : ((WalletIDs?, Error?)->Void)? = nil ) {
        
        Config.setup()
        
        let countryCode = user.countryCode ?? "MY"
        let phoneNumber = user.phoneNumber ?? ""
        let email = user.email ?? ""
        let walletRefId = wallet.refIdForService ?? ""
        
        let addr = RPDAddress()
        addr.name = address?.id ?? "xxx"
        addr.line1 = address?.line1 ?? "line 1"
        addr.country = RPDCountry.country(isoAlpha2: countryCode)
        addr.city = address?.city ?? "City"
        
        
        let contact = RPDEWalletContactRequestBuilder(contactType: .personal,
        firstName: user.firstName ?? "", lastName: user.lastName ?? "", email: email,
        phoneNumber: phoneNumber, businessDetails: nil,
        dateOfBirth: user.dob ,
        middleName: "",
        secondLastName: "",
        identificationNumber: "100",
        gender: RPDGenderType.male,
        residence: RPDResidenceType.own,
        maritalStatus: .none,
        identificationType: "PA",
        address: addr,
        country: RCountry.country(isoAlpha2: countryCode) )
        
        
        let usersManager = RPDUsersManager()
        
        usersManager.createUser(phoneNumber: phoneNumber,
            eWalletType: self.toRWalletType(wallet), firstName: user.firstName ?? "",
            lastName: user.lastName ?? "", email: email,
            eWalletReferenceID: walletRefId ,
            contact: contact, metadata: genericMetaData, completionBlock:{
            
            usr, error in
            
            if let error = error {
        
                completion?(nil,  error )
                return
            }
                
            if let usr = usr {
            
                let wids = WalletIDs(from: usr)
            
                completion?(wids, nil)
                
            }
            else {
                
                completion?(nil,nil)
            }
            
        })
        
    }
    
    
    
    func updateWallet(with user : User, wallet : UserWallet) {
        
        Config.setup()
       
        let userManager: RPDUsersManager = RPDUsersManager()
        userManager.updateUser(firstName: user.firstName ?? "" ,
                               lastName: user.lastName ?? "",email: user.email ?? "",
                               eWalletReferenceID: wallet.refIdForService ?? "",metadata: genericMetaData) { user, error in
            
            guard let err = error else {
                if let user = user {
                    print("updated::\(user.firstName ?? ""), refId::\(user.eWalletReferenceID ?? "")")
                }
                return
            }
            
            
            print("updating.wallet.err:\(err)")
           
        }
    }
    
    
    private func deleteWallet(){
        
        Config.setup()
       
       // let contactId = RPDUser.currentUser()?.contacts?.dataList?.first?.ID
        
        let userManager:RPDUsersManager = RPDUsersManager()
    
        userManager.deleteUser(completionBlock: { error in
           
            guard let err = error else {
   
                print("user.deleted.trying.delete.contact:: ")
                
                /**
                if let contactId = contactId {
                    
                    RPDEWalletContactsManager().delete(contactWithID: contactId , completionBlock: {
                        
                        resp, err in
                        
                        guard let err = err else {
                            
                            return
                        }
                        
                        print("deleting.contact.err::\(err)")
                        
                        
                    })
                   
                }
                 */
                
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
    
    func attachWallet(user : User, wallet : UserWallet, completion : ((WalletIDs?, Error?)->Void)? = nil ){
        
        Config.setup()
       
        let ruser : RPDUser = RPDUser()
        ruser.phoneNumber = user.phoneNumber ?? ""
        ruser.email = user.email ?? ""
        ruser.eWalletReferenceID = wallet.refId ?? ""
    
                    
        let userManager:RPDUsersManager = RPDUsersManager()
        userManager.attachUser(ruser, completionBlock: { usr, error in
          // Enter your code here.
            
            guard let err = error else {
            
                if let usr = usr  {
                
                    let walletIDs = WalletIDs(from: usr) 
                    completion?(walletIDs, nil)
                    
                }
                else {
                    
                    completion?(nil, nil)
                }
                
                return
            }
            
            
            completion?(nil,err)
        
            
            
        })
    }
    
    func currentWallet(attachIfNotPresent user : User, wallet : UserWallet, completion : ((WalletIDs?, Error?)->Void)? = nil,
    toPrint : Bool = false ){
        
        Config.setup()
       
        if let ruser = RPDUser.currentUser() {
  
            if toPrint {
                
                print("RPD.user::.id::\(ruser.id ?? "")::\(ruser.firstName ?? "") \(ruser.lastName ?? "") : wallet.refId::\(ruser.eWalletReferenceID ?? "xxx") ::balance::")
            }
            
            let walletIDs = WalletIDs(from: ruser)
            
            completion?(walletIDs, nil)
            
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

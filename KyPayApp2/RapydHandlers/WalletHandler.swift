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
    

    func createWallet(for user : User, wallet : UserWallet,
        address : UserAddress? = nil ,
        completion : ((User?, Error?)->Void)? = nil ) {
        
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
            eWalletReferenceID: wallet.refId ?? "", contact: contact, metadata: ["game": "uncharted"], completionBlock:{
            
            _, error in
            
            if let error = error {
        
                completion?(nil, error )
                return
            }
        
            completion?(user, nil)
            
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
    
    func attachWallet(user : User, wallet : UserWallet, completion : ((Error?)->Void)? = nil ){
        
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
            
            completion?(err)
            
        })
    }
    
    func currentWallet(attach user : User, wallet : UserWallet, completion : ((Error?)->Void)? = nil, toPrint : Bool = false ){
        
        Config.setup()
       
        if let ruser = RPDUser.currentUser() {
  
            if toPrint {
           
                print("RPD.user::\(ruser.firstName ?? "") \(ruser.lastName ?? "") : wallet.id::\(ruser.eWalletReferenceID ?? "xxx")")
            }
        }
        else {
            
            self.attachWallet(user: user, wallet: wallet, completion: completion)
        }
    }
}

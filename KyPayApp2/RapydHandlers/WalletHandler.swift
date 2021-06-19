//
//  WalletHandler.swift
//  KyPay
//
//  Created by Chee Ket Yung on 04/06/2021.
//

import Foundation
import RapydSDK

typealias WalletType = RapydSDK.RPDWalletType
typealias Gender = RapydSDK.RPDGenderType
typealias ResidenceType = RapydSDK.RPDResidenceType
typealias MaritalStatus = RapydSDK.RPDMaritalStatusType

class WalletHandler : NSObject {
    

    func createWallet(for user : User, completion : ((User)->Void)? = nil ) {
        
        Config.setup()
        
        let address = RPDAddress()
        address.name = "a1"
        address.line1 = "line1"
        address.country = RPDCountry.country(isoAlpha2: "IL")
        address.city = "City"
        
        
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
        address: address,
        country: RCountry.country(isoAlpha2:"US") )
        
        
        let usersManager = RPDUsersManager()
        
        usersManager.createUser(phoneNumber: user.phoneNumber ?? "", eWalletType: .person,
            firstName: user.firstName ?? "", lastName: user.lastName ?? "", email: user.email ?? "",
            eWalletReferenceID: "xxxxx", contact: contact,
            metadata: ["game": "uncharted"], completionBlock:{
            
            ruser, error in
            
                
            guard let error = error else {
        
                if let completion = completion {
                    
                    
                    completion(user)
                }
                
                return
        
            }
            
            print("err:\(error)")
       
            
            
        })
        
    }
    
}

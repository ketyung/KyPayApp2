//
//  User.swift
//  KyPayApiTester
//
//  Created by Chee Ket Yung on 08/06/2021.
//

import Foundation

struct User : Codable {

    enum Stat : String, Codable{        
        case signedIn  = "SI"
        
        case signedOut = "SO"
        
        case none  = "none"
    }


    enum AccountType : String, Codable {

        case business = "B"
        
        case personal = "P"
        
        case others = "O"
    }

    
    var id : String?
    var firstName : String?
    var lastName : String?
    var dob : Date?
    var email : String?
    var phoneNumber : String?
    var accountType : AccountType?
    var stat : Stat?
    var countryCode : String?
    var lastStatTime : Date?
    var lastUpdated : Date?

}

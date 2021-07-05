//
//  Seller.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import Foundation

struct Seller : Codable, Hashable {
    
    var id : String?
    var uid : String?
    var name : String?
    var description : String?
    var email : String?
    var phoneNumber : String?
    var walletRefId : String?
    var serviceWalletId : String?
    var serviceCustId : String?
    var lastUpdated : Date?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

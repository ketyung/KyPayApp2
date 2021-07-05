//
//  CartPaymentSuccessInfo.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 05/07/2021.
//

import Foundation


struct SellerOrder : Codable {
    
    var seller : Seller?
    
    var items : [CartItem]?
    
    var total : Double?
    
    var servicePaymentId : String?
    
}

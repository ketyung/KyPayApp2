//
//  SellerItem.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import Foundation

struct SellerItem : Codable {
    
    var id : String?
  //  var sellerId : String?
    var seller : Seller?
    var name : String?
    var description : String?
    var category : SellerCategory?
    var price : Double?
    var currency : String?
    var qoh : Int?
    var images : [SellerItemImage]?
    var shippingFee : String?
    var lastUpdated : String?
}

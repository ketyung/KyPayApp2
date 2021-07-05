//
//  CartItem.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import Foundation

struct CartItem : Equatable, Codable {
    
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        
        lhs.item.id == rhs.item.id
    }
    
    var item : SellerItem
    
    var quantity : Int = 0
    
    var subTotal : Double {
        
        (item.price ?? 0) * Double(quantity)
    }
  
}

//
//  CartViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import Foundation

class CartViewModel : ObservableObject {
    
    @Published private var items : [CartItem] = []
    
    
    func add(item : SellerItem) {
        
        let cartItem = CartItem(item: item, quantity: 1)
        
        if items.contains(cartItem){
            
            let idx = items.firstIndex(of: cartItem) ?? 0
            var itm = items[ idx ]
            itm.quantity += 1
            
            items [ idx ] = itm
           
        }
        else {
            
            items.append(cartItem)
        }
    }
    
    func remove(item : SellerItem) {
        
        let cartItem = CartItem(item: item, quantity: 1)
        
        if items.contains(cartItem) {
            
            let idx = items.firstIndex(of:cartItem) ?? 0
            var itm = items[ idx ]
            
            if itm.quantity > 1 {
                
                itm.quantity -= 1
                items[idx] = itm
            }
            else {
                items.remove(at: idx)
            }
        
           
        }
        
    }
    
    
}

extension CartViewModel {
    
    func quantityOfItem(_ item : SellerItem) -> Int {
        
        let cartItem = CartItem(item : item)
      
        if items.contains( cartItem ) {
            
            let idx = items.firstIndex(of: cartItem) ?? 0
          
            let item = items[ idx ]
            
            return item.quantity
        }
        
        return 0
    }
    
    
    func total() -> Int {
        
        var totalQty = 0
        items.forEach{
            item in
            
            totalQty += item.quantity
        }
        
        return totalQty
    }
    
    
    var cartItems : [CartItem] {
        
        items
    }
    
    // dictionary group items by seller 
    var itemsBySeller : Dictionary<String, [CartItem]>{
        
        Dictionary(grouping: items, by: { (element: CartItem) in
            
            return "\(element.item.seller?.name ?? "") - \(element.item.seller?.id ?? "")"
            
        })
        
    }
    
    var itemSellers : [String] {
        
        Array(itemsBySeller.keys).sorted(by: {$0 < $1})
    }
    
    func subTotalAmountBy(seller : String, currency : inout String ) -> Double{
        
        var subTotal : Double = 0
        if let items = itemsBySeller[seller] {
            
            currency = items.first?.item.currency ?? Common.defaultCurrency
            
            subTotal = items.map({$0.subTotal}).reduce(0,+)

        }
        
        return subTotal
    }
    
    
    func totalAmount(currency : inout String) -> Double {
        
        currency = items.first?.item.currency ?? Common.defaultCurrency
     
        return items.map({$0.subTotal}).reduce(0,+)
    }
    
}

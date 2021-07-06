//
//  CartViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import Foundation

class CartViewModel : ObservableObject {
    
    @Published private var items : [CartItem] = []
    
    private lazy var txHandler = TxHandler()
    
    @Published var errorPresented = false
    
    @Published var errorMessage : String?
    
    @Published var inProgress : Bool = false
    
    @Published var paymentSuccess : Bool = false
    
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
    
    // dictionary group items by seller name and id
    var itemsBySeller : Dictionary<Seller, [CartItem]>{
        
        Dictionary(grouping: items, by: { (element: CartItem) in
            
            return element.item.seller ?? Seller()
        })
    }
    
    
    var itemSellers : [Seller] {
        
        Array(itemsBySeller.keys).sorted(by: {$0.name ?? "" < $1.name ?? ""})
    }
    
    func subTotalAmountBy(seller : Seller, currency : inout String ) -> Double{
        
        var subTotal : Double = 0
        if let items = itemsBySeller[seller] {
            
            currency = items.first?.item.currency ?? Common.defaultCurrency
            
            subTotal = items.map({$0.subTotal}).reduce(0,+)

        }
        
        return subTotal
    }
    
    
    func totalAmount(currency : inout String) -> Double {
        
        currency = items.first?.item.currency ?? Common.defaultCurrency
     
        return totalAmount()
    }
   
    func totalAmount() -> Double {
        
        return items.map({$0.subTotal}).reduce(0,+)
    }
   
}


extension CartViewModel {
    
    func payByWallet(by user : User, with walletRefId : String){
        
        self.inProgress = true
        
        
        txHandler.transfer(for: self, by: user, wallertRefId: walletRefId, completion: {
            
            [weak self] order, err in
            
            guard let err = err else {
                
                if let order = order {
                    
                    
                    self?.recordOrderRemotely(order)
                }
                
                
                return
            }
            
            
            DispatchQueue.main.async {
                
                self?.errorPresented = true
                self?.errorMessage = err.localizedDescription
                self?.inProgress = false
            }
            return
            
        })
    }
    
    
    
    private func recordOrderRemotely(_ order : Order) {
        
        // add order to remote
        ARH.shared.addOrder(order, returnType:Order.self , completion: {
            
            res in
            
            switch(res) {
            
                case .failure(let err) :
                    
                    DispatchQueue.main.async {
                        self.errorPresented = true
                        self.errorMessage = err.localizedDescription
                    }
                    
                case .success(_) :
                    
                    DispatchQueue.main.async {
                  
                        self.inProgress = false
                        self.paymentSuccess = true
        
                    }
                
            }
        })
    }
    
    

    
    
}

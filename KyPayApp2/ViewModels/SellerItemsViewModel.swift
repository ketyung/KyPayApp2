//
//  SellerItemsViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import Foundation

class SellerItemsViewModel : ObservableObject {
    
    @Published private var items : [SellerItem] = []
    
    @Published var errorPresented : Bool = false
    
    @Published var errorMessage : String?
    
    @Published var inProgress : Bool = false
    
    var sellerItems : [SellerItem] {
        
        get {
            items
        }
    }
    
    
    var byCategories : Dictionary<String, [SellerItem]>{
        
        Dictionary(grouping: sellerItems, by: { (element: SellerItem) in
            return element.category?.name ?? ""
        })
        
    }
    
    var categoryKeys : [String] {
        
        Array(byCategories.keys).sorted(by: {$0 < $1})
    }
}

extension SellerItemsViewModel {
    
    func fetchSellerItems(currency : String){
        
        if items.count == 0 {
        
            self.inProgress = true
            
            ARH.shared.fetchSellerItems(currency: currency, completion: {
                [weak self] res in
                
                guard let self = self else {return}
                
                DispatchQueue.main.async {
                 
                    switch (res) {
                    
                        case .failure(let err) :
                            self.errorMessage = err.localizedDescription
                            self.errorPresented = true
                            self.inProgress = false
                            
                        case .success(let items) :
                            self.items = items
                            self.inProgress = false
                            
                    }
                }
                
            })
        }
        
    }
    
}

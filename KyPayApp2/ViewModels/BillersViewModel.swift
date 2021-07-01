//
//  BillersViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 01/07/2021.
//

import Foundation

class BillersViewModel : ObservableObject {
    
    @Published var billers : [Biller] = []
    
    @Published var showProgressIndicator : Bool = false

    @Published var errorPresented : Bool = false
    
    @Published var errorMessage : String = ""
    
    func fetchBillers(country : String){
        
        if billers.count > 0 {
            
            return
        }
        
        
        self.showProgressIndicator = true
        ARH.shared.fetchBillers(country: country, completion: { [weak self] res in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
             
                switch(res) {
                
                    case .failure(let err) :
                        
                        self.errorPresented = true
                        self.errorMessage = err.localizedDescription
                        
                    case .success(let billers) :
                    
                        self.billers = billers
                    
                        
                }
                
                self.showProgressIndicator = false 
            }
            
        })
    }
    
}



//
//  TopUpPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation

class TopUpPaymentViewModel : ObservableObject {
    
    @Published private var amount : Double?
    
    @Published var errorMessage : String?
    
    var topUpAmount : String {
        
        get {
            "\(amount?.roundTo(places: 2) ?? 0.00)"
        }
        
        set(newVal){
            
            let amt = newVal.toDouble()
            if (amt ?? 0)  > 2000 {
                
                errorMessage = "Maximum amount : 2000"
            }
            else {
                
                amount = amt
                errorMessage = nil 
            }
        }
    }
}

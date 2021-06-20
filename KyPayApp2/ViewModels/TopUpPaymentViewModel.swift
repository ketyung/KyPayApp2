//
//  TopUpPaymentViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation
import SwiftUI

class TopUpPaymentViewModel : ObservableObject {
    
    @Published private var amount : Int?
    
    @Published var errorMessage : String?
    
    var topUpAmount : String {
        
        get {
            "\(amount ?? 0)"
        }
        
        set(newVal){
            
            var amtTxt = newVal
            
            if amtTxt.count > 4 {
                
                amtTxt =  String(amtTxt.prefix(4))
            }
            
            let amt = Int(amtTxt)
            
            withAnimation{
            
                if (amt ?? 0)  > 2000 {
                    
                    errorMessage = "Maximum amount : <curr> 2000"
                }
                else {
                    
                    errorMessage = nil
                }
            }
            
            amount = amt
        
        }
    }
}

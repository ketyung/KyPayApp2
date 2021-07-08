//
//  MoneyRequestViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 08/07/2021.
//

import Foundation

class MoneyRequestViewModel : ObservableObject {
    
    @Published private var moneyRequest = MoneyRequest()
    
    @Published private var focusIndex : Int = 0
    
    var amountText : String {
        
        get {
            
           ( moneyRequest.total ?? 0).twoDecimalString
            
        }
        
        set(newVal){
            
            moneyRequest.total = Double(newVal) ?? 0
        }
    }
    
    
    func focusIndexByPhoneNumber ( _ phoneNumber : String ){
    
        if let item = moneyRequest.items?.first(where: { $0.phoneNumber == phoneNumber }), let idx = moneyRequest.items?.firstIndex(of: item) {
            
            self.focusIndex = idx 
        }
    }
    
    
    
    
    var amountOfFocus : String {
        
        get {
            
            (moneyRequest.items?[safe : self.focusIndex]?.amount ?? 0).twoDecimalString
        }
        
        set(newVal){
            
            if (moneyRequest.items?.indices.contains(self.focusIndex) ?? false) {
                
                moneyRequest.items?[self.focusIndex].amount = Double(newVal)
            }
        }
    }
    
    
    
}

extension MoneyRequestViewModel {
    
    func addRequestBy( _ contact : Contact){
        
        let mrq = MoneyRequestItem(phoneNumber : contact.phoneNumber)
        
        guard let _ = moneyRequest.items else {
            
            moneyRequest.items = []
            
            moneyRequest.items?.append(mrq)
            return
        }
        
        moneyRequest.items?.append(mrq)
    
    }
    
    
    func reset(){
        
        moneyRequest = MoneyRequest()
    }
}

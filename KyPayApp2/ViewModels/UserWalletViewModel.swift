//
//  UserWalletViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation

class UserWalletViewModel : ObservableObject {
    
    @Published private var wallet = UserWallet()
    
    @Published private var showingProgressIndicator : Bool = false
    
    var id : String {
        
        get {
            wallet.id ?? ""
        }
        
        set(newVal){
            
            wallet.id = newVal
        }
    }
    
    
    var refId : String {
        
        get {
            
            wallet.refId ?? ""
        }
        
        set(newVal){
            
            wallet.refId = newVal
        }
    }
    
    
    var type : UserWallet.WalletType {
        
        get {
            wallet.type ?? .personal
        }
        
        set(newVal){
            
            wallet.type = newVal
        }
    }
    
    
    var progressIndicatorPresented : Bool {
        
        get {
            
            showingProgressIndicator
        }
        
        set(newVal){
            
            showingProgressIndicator = newVal
        }
    }
    
}


extension UserWalletViewModel {
    
    
    func fetchWalletIfNotPresent( user : User, completion :((Error?) -> Void)? = nil ) {
        
        let walletType = user.allowedWalletTypes.first ?? .personal
        let currency = CurrencyManager.currency(countryCode: user.countryCode ?? "MY") ?? "MYR"
        
        guard let _ = KDS.shared.getWallet(type: walletType ,
        currency: currency ) else {
            
            self.showingProgressIndicator = true
            
            ARH.shared.fetchUserWallet(id: user.id ?? "", type: walletType, currency: currency, completion: {
              
                res in
                
                switch(res) {
                
                    case .failure(let err) :
                        
                        
                        if var err = err as? ApiError, err.statusCode == 404 {
                            
                            // to create wallet if not exists
                            err.errorText = "Wallet Not Found!"
        
                            completion?(err)
                        
                        }
                        else {
                        
                            completion?(err)
                        
                        }
                        
                    case .success(let rs) :
                    
                        KDS.shared.saveWallet(rs)
                        
                        print("wallet.saved::\(rs.id ?? ""):\(rs.refId ?? ""):\(rs.balance ?? 0)")
                }
                
                DispatchQueue.main.async {
               
                    self.showingProgressIndicator = false
                   
                }
                
            })
            
            
            return
        }
    }
}

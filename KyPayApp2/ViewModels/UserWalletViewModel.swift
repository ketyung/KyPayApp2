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
        
        guard let wallet = KDS.shared.getWallet(type: walletType , currency: currency ) else {
            
            self.showingProgressIndicator = true
            
            self.fetchWalletRemotely(user: user, walletType:walletType, currency: currency, completion: completion)
            
            return
        }
        
        WalletHandler().currentWallet(attachIfNotPresent: user, wallet: wallet, completion: { [weak self] ids, err in

            guard let self = self else { return }
            
            // update to remote wallet
            self.updateWalletRemotely(wallet, ids: ids, completion: completion)
            //completion?(err)
            
            
        })
        
    }
}


extension UserWalletViewModel {
    
    
    func fetchWalletRemotely(user : User,
                             walletType : UserWallet.WalletType,
                             currency : String,
                             completion :((Error?) -> Void)? = nil){
        
        ARH.shared.fetchUserWallet(id: user.id ?? "", type: walletType, currency: currency, completion: {[weak self]
            res in
            
            guard let self = self else {
                return
            }
            
            switch(res) {
            
                case .failure(let err) :
                    
                    
                    if let err = err as? ApiError, err.statusCode == 404 {
                        
                        // to create wallet if not exists
                        self.createWalletIfNotPresent(user: user, walletType: walletType, currency: currency,
                                                      completion: completion)
                    }
                    else {
                    
                        completion?(err)
                    
                    }
                    
                case .success(let rs) :
                
                    KDS.shared.saveWallet(rs)
                    
                    
                    self.createRapydWallet(user: user, wallet: rs)
                                  
                    completion?(nil)
            }
            
            DispatchQueue.main.async {
           
                self.showingProgressIndicator = false
               
            }
            
        })
    }
    
    
    private func updateWalletRemotely(_ wallet : UserWallet, ids : WalletIDs? ,  completion :((Error?) -> Void)? = nil){
        
        
        var updatedWallet = wallet
        updatedWallet.serviceContactId = ids?.contactId
        updatedWallet.serviceAddrId = ids?.addrId
        updatedWallet.serviceWalletId = ids?.walletId
        updatedWallet.serviceCustId = ids?.custId
        
        ARH.shared.updateUserWallet(updatedWallet, returnType: UserWallet.self,  completion: {
            
            res in
            
            switch(res) {
            
                case .failure(let err) :
                    completion?(err)
                    
                case .success(_) :
                    completion?(nil)
                    
            }
        })
    }
    
}

extension UserWalletViewModel {
    
    func createWalletIfNotPresent(user : User,
                                  walletType : UserWallet.WalletType,
                                  currency : String,
                                  completion :((Error?) -> Void)? = nil){
        
        let wallet = UserWallet(id: user.id ?? "", balance : 0, currency: currency, type: walletType)
        ARH.shared.addUserWallet(wallet, returnType: UserWallet.self, completion: { [weak self]
            
            res in
        
            guard let self = self else
            {
                return
            }
            
            switch(res) {
            
                case .failure(let err) :
                    
                    completion?(err)
                    
        
                case .success(let rs) :
                    
                    if let createdWallet = rs.returnedObject {
                   
                        KDS.shared.saveWallet(createdWallet)
                 
                       // print("wallet.created::\(createdWallet.id ?? ""):\(createdWallet.refId ?? ""):\(createdWallet.balance ?? 0)")
          
                        self.createRapydWallet(user: user, wallet: createdWallet)
                        
                        completion?(nil)
                    }
                    else {
                        
                        completion?(ApiError(errorText: "Returned Wallet Object is nil!".localized, statusCode: -1))
                    }
                    
                 
            }
            
            DispatchQueue.main.async {
           
                self.showingProgressIndicator = false
               
            }
            
        })
    }
    
}

extension UserWalletViewModel {
    
    
    private func createRapydWallet( user : User, wallet : UserWallet){
        
        
        let walletHandler = WalletHandler()
    
        walletHandler.attachWallet(user: user, wallet: wallet, completion: { [weak self ] ids, err in
            guard let self = self else { return }
            
            guard let _ = err else {
                
                self.updateWalletRemotely(wallet, ids: ids)
                return
            }
       
            //  create the wallet if cannot attach
            walletHandler.createWallet(for: user, wallet: wallet, completion: {[weak self] ids, err in
                guard let self = self else { return }
               
                guard let err = err else {
                    
                    self.updateWalletRemotely(wallet, ids: ids)
                    return
                }
                
                print("Create.wallet.from.Rapyd.err:\(err)")
                
            })
        })
        
       
    }
}


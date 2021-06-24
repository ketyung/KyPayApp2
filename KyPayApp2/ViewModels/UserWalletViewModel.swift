//
//  UserWalletViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation

private struct UserWalletHolder{
    
    var wallet : UserWallet = UserWallet()
}


class UserWalletViewModel : ObservableObject {
    
    @Published private var walletHolder = UserWalletHolder()
    
    @Published private var showingProgressIndicator : Bool = false
    
    private lazy var walletHandler = WalletHandler()
    
    var id : String {
        
        get {
            walletHolder.wallet.id ?? ""
        }
        
        set(newVal){
            
            walletHolder.wallet.id = newVal
        }
    }
    
    
    var refId : String {
        
        get {
            
            walletHolder.wallet.refId ?? ""
        }
        
        set(newVal){
            
            walletHolder.wallet.refId = newVal
        }
    }
    
    
    var serviceCustId : String? {
        
        get {
            
            walletHolder.wallet.serviceCustId
        }

    }
    
    
    var type : UserWallet.WalletType {
        
        get {
            walletHolder.wallet.type ?? .personal
        }
        
        set(newVal){
            
            walletHolder.wallet.type = newVal
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
        
        self.walletHandler.currentWallet(attachIfNotPresent: user, wallet: wallet, completion: { [weak self] ids, err in

            guard let self = self else { return }
            
            // update to remote wallet
            //print("curr.wallet::\(wallet)")
            self.updateWalletRemotelyIfNeeded(wallet, ids: ids, completion: completion)
            
        })
        
    }
}


extension UserWalletViewModel {
    
    
    private func fetchWalletRemotely(user : User, walletType : UserWallet.WalletType,currency : String,
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
                    // set to wallet in session
                    DispatchQueue.main.async {
                        self.walletHolder.wallet = rs
                    }
                    
                    self.createRapydWallet(user: user, wallet: rs)
                                  
                    completion?(nil)
            }
            
            DispatchQueue.main.async {
           
                self.showingProgressIndicator = false
               
            }
            
        })
    }
    
    
    private func updateWalletRemotelyIfNeeded(_ wallet : UserWallet, ids : WalletIDs? ,  completion :((Error?) -> Void)? = nil){
        
        var updatedWallet = wallet
        
        var toUpdateRemote = false
        
        if let contactId = ids?.contactId, updatedWallet.serviceContactId == nil {
            updatedWallet.serviceContactId = contactId
            toUpdateRemote = true
        }
        if let addrId = ids?.addrId,  updatedWallet.serviceAddrId == nil {
            updatedWallet.serviceAddrId = addrId
            toUpdateRemote = true
        }
        if let walletId = ids?.walletId, updatedWallet.serviceWalletId == nil {
            updatedWallet.serviceWalletId = walletId
            toUpdateRemote = true
        }
        if let custId = ids?.custId, updatedWallet.serviceCustId == nil {
            updatedWallet.serviceCustId = custId
            toUpdateRemote = true
        }
        
        DispatchQueue.main.async {
            self.walletHolder.wallet = updatedWallet
        }
     
       
        if toUpdateRemote  {
            // update the wallet in session
            ARH.shared.updateUserWallet(updatedWallet, returnType: UserWallet.self,  completion: { res in
                
                switch(res) {
                
                    case .failure(let err) :
                        completion?(err)
                        
                    case .success(_) :
                        completion?(nil)
                }
            })
        }
        
    }
    
}

extension UserWalletViewModel {
    
    private func createWalletIfNotPresent(user : User,
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
                        
                        self.createRapydWallet(user: user, wallet: createdWallet)
                        
                        // update the wallet in session
                        DispatchQueue.main.async {
                            self.walletHolder.wallet = wallet
                        }
                        
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
        
    
        walletHandler.attachWallet(user: user, wallet: wallet, completion: { [weak self ] ids, err in
            guard let self = self else { return }
            
            guard let _ = err else {
                
                self.updateWalletRemotelyIfNeeded(wallet, ids: ids)
                return
            }
       
            //  create the wallet if cannot attach
            self.walletHandler.createWallet(for: user, wallet: wallet, completion: {[weak self] ids, err in
                guard let self = self else { return }
               
                guard let err = err else {
                    
                    self.updateWalletRemotelyIfNeeded(wallet, ids: ids)
                    return
                }
                
                print("Create.walletHolder.wallet.from.Rapyd.err:\(err)")
                
            })
        })
        
       
    }
}


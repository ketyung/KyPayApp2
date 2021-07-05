//
//  UserWalletViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import Foundation


struct CustomError : LocalizedError, CustomStringConvertible {
   
    var description: String {
        
        errorText ?? ""
    }

    var errorText : String?
    
    public var errorDescription : String {
        
        errorText ?? ""
    }
    
}



private struct UserWalletHolder{
    
    var wallet : UserWallet = UserWallet()
}


class UserWalletViewModel : ObservableObject {
    
    @Published private var walletHolder = UserWalletHolder()
    
    @Published private var showingProgressIndicator : Bool = false
    
    private lazy var walletHandler = WalletHandler()
    
    private lazy var txHandler = TxHandler()
    
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
    
    var balanceValue : Double {
   
        walletHolder.wallet.balance ?? 0
    }
    
    var balance : String {
        
        get {
            
            "\((walletHolder.wallet.balance ?? 0).twoDecimalString)"
        }
    }
    
    var currency : String {
        
        get{
            
            walletHolder.wallet.currency ?? Common.defaultCurrency
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
    
    
    var walletSenderID : String? {
        
        get {
            
            walletHolder.wallet.servicePoSenderId
        }
    }
    
   
}


extension UserWalletViewModel {
    
    
    func fetchWalletIfNotPresent( user : User, completion :((Error?) -> Void)? = nil ) {
        
        let walletType = user.allowedWalletTypes.first ?? .personal
        let currency = CurrencyManager.currency(countryCode: user.countryCode ?? Common.defaultCountry) ?? Common.defaultCurrency
        
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
        
        if let balance = ids?.balance, updatedWallet.balance != ids?.balance {
            
            updatedWallet.balance = balance
            toUpdateRemote = true // update balance according to service
           // print("sync.to..remote..wallet.balance::\(updatedWallet.balance ?? 0)")
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
    
    
    private func updateWalletInSessionForCustId(walletIDs : WalletIDs?, user : User){
        
        let walletType = user.allowedWalletTypes.first ?? .personal
        let currency = CurrencyManager.currency(countryCode: user.countryCode ?? Common.defaultCountry) ?? Common.defaultCurrency
        
        if var savedWallet = KDS.shared.getWallet(type: walletType, currency: currency){
            
            savedWallet.serviceCustId = walletIDs?.custId
            KDS.shared.saveWallet(savedWallet)
        }
       
        
        DispatchQueue.main.async {
       
            self.walletHolder.wallet.serviceCustId = walletIDs?.custId
        }
    }
    
    
    private func createRapydWallet( user : User, wallet : UserWallet){
        
       
        walletHandler.attachWallet(user: user, wallet: wallet, completion: { [weak self ] ids, err in
            guard let self = self else { return }
            
            
            guard let _ = err else {
                
                self.updateWalletInSessionForCustId(walletIDs: ids, user: user)
                
                self.updateWalletRemotelyIfNeeded(wallet, ids: ids)
                
                
                return
            }
       
            //  create the wallet if cannot attach
            self.walletHandler.createWallet(for: user, wallet: wallet, completion: {[weak self] ids, err in
                guard let self = self else { return }
               
                guard let err = err else {
                    
                    self.updateWalletInSessionForCustId(walletIDs: ids, user: user)
                   
                    self.updateWalletRemotelyIfNeeded(wallet, ids: ids)
                    return
                }
                
                print("Create.walletHolder.wallet.from.Rapyd.err:\(err)")
                
            })
        })
        
       
    }
}




extension UserWalletViewModel {
    
    
    func addPaymentTxRemotely ( amount : Double , currency : String, user : User,
                                walletRefId : String, toUserId : String? = nil,
                                toUserIdType : UserPaymentTx.UidType? = .user_id,
            toWalletRefId : String? = nil, method : String, note : String? = nil,
            serviceId : String? = nil , txType : UserPaymentTx.TxType,
            status : UserPaymentTx.Stat = .success , completion : ((Error?) -> Void)? = nil ){
        
        let pmTx = UserPaymentTx(uid : user.id ?? "", toUid:  toUserId ?? user.id ?? "",
                                 toUidType: toUserIdType, txType : txType, walletRefId: walletRefId,
                                 toWalletRefId:  toWalletRefId, amount:  amount, currency: currency,
                                 method: method, note: note, serviceId: serviceId, stat: status)
        
        //print("add.pay.tx::\(serviceId ?? "xxxx")")
        //print("add.pay::.note::\(note ?? "xxxx.x")")
        
        ARH.shared.addUserPaymentTx(pmTx, returnType: UserPaymentTx.self,  completion: {
            
            res in
            
            switch(res) {
            
                case .failure(let err) :
                    completion?(err)
                
                case .success(_) :
                    completion?(nil)
                
            }
            
        })
        
    }
    
    
    func updateWalletRemotely(by adding : Double, for user : User,
                              method : String, serviceId : String? = nil ,
                              toUserId : String? = nil, toWalletRefId : String? = nil,
                              note : String? = nil, txType : UserPaymentTx.TxType = .walletTopUp,
                               completion : ((Error?) -> Void)? = nil ){
        
        let newBalance = (self.walletHolder.wallet.balance ?? 0) + adding
        
        let walletToBeUpdated = UserWallet(id : self.walletHolder.wallet.id , refId:
        self.walletHolder.wallet.refId, balance: newBalance)
        
        // update wallet in session
        DispatchQueue.main.async {
       
            self.walletHolder.wallet.balance = newBalance
        }
        
        let walletType = user.allowedWalletTypes.first ?? .personal
        let currency = CurrencyManager.currency(countryCode: user.countryCode ?? Common.defaultCountry) ?? Common.defaultCurrency
        
        // update wallet in KDS
        if var savedWallet = KDS.shared.getWallet(type: walletType, currency: currency){
            
            savedWallet.balance = newBalance
            KDS.shared.saveWallet(savedWallet)
        }
        
        // Now update remotely
        ARH.shared.updateUserWallet(walletToBeUpdated, returnType: UserWallet.self,  completion: { res in
            
            switch(res) {
            
                case .failure(let err) :
                    completion?(err)
                    
                case .success(_) :
                    // record a payment tx remotely
                    self.addPaymentTxRemotely(amount: adding, currency: currency, user: user,
                    walletRefId: walletToBeUpdated.refId ?? "",
                    toUserId: toUserId, toWalletRefId: toWalletRefId,
                    method: method, note: note, serviceId: serviceId,
                    txType: txType, completion: completion)
                    
                   // print("record.tx.to.remote::\(toUserId ?? "zzz")::\(toWalletRefId ?? "xxx")")
                    
            }
        })
        
    }
    
    
    func add(amount : Double, card: Card, for user : User, completion : ((PaymentData?, Error?)->Void)? = nil ){
        
        if let custId = self.serviceCustId {
  
            let currency = CurrencyManager.currency(countryCode: user.countryCode ?? Common.defaultCountry) ?? Common.defaultCurrency
            
            self.walletHandler.add(card: card, amount: amount, currency: currency, customerId: custId, completion: {
                [weak self] pmdata , error in
                
                
                guard let err = error else {
                    
                    guard let self = self else { return }
                    
                    self.updateWalletRemotely(by: amount, for: user, method: card.paymentTypeBasedOnCardType,
                    serviceId: pmdata?.id, completion: { err in
                        
                        guard let err = err else {
                            
                            completion?(pmdata, nil)
                            return
                        }
                        
                        completion?(pmdata, err)
                    })
                   
                    
                    return
                }
                
                completion?(nil, err)
                
            })
            
        }
        
        
    }
    
    
    
    func add(amount : Double, paymentMethod : PaymentMethod, for user : User, completion : ((PaymentData?, Error?)->Void)? = nil ){
        
        if let custId = self.serviceCustId {
  
            let currency = CurrencyManager.currency(countryCode: user.countryCode ?? Common.defaultCountry) ?? Common.defaultCurrency
            
            
            self.walletHandler.add(amount: amount, currency: currency,
                paymentMethod: paymentMethod,customerId: custId, completion: {[weak self] pmdata , error in
                    
                
                guard let err = error else {
                    
                    guard let self = self else { return }
                    
                    self.updateWalletRemotely(by: amount, for: user, method: paymentMethod.type ?? "",
                    serviceId: pmdata?.id, completion: { err in
                        
                        guard let err = err else {
                            
                            completion?(pmdata, nil)
                            return
                        }
                        
                        completion?(pmdata, err)
                    })
                    
                    return
                }
                    
                completion?(nil, err)
                                    
            })
            
        }
        else {
            
            completion?(nil, CustomError(errorText: "Wallet has NO customer ID!!".localized))
        }
        
    }
    
}


extension UserWalletViewModel {
    
    func sendMoney(from user : User, to phoneNumber : String, amount : Double,
                   toUserId : String? = nil, toWalletRefId : String? = nil,
                   note : String? = nil, completion : ((String?, Error?)->Void)? = nil ){
        
        let bal = (self.walletHolder.wallet.balance ?? 0)
      
        if amount <= 0 {
            completion?(nil, CustomError(errorText: "Invalid amount :\(amount.twoDecimalString)!".localized))
            return
        
        }
        
        if amount > bal {
            completion?(nil, CustomError(errorText: "Insufficient fund in your wallet, balance :\(bal.twoDecimalString)!".localized))
            return
        }
        
        txHandler.transfer(to: phoneNumber, amount: amount, currency: self.currency, completion: {
            [weak self] id, err  in
            
            guard let self = self else { return }
            
            guard let err = err else {
                
                self.updateWalletRemotely(by: -amount,
                for: user, method: "kypay_send_money", serviceId: id,
                toUserId : toUserId, toWalletRefId: toWalletRefId,
                note: note, txType: .sendMoney,
                completion: { err in
                    
                    guard let err = err else {
                        
                        completion?(id, err)
                        return
                    }
                    
                    completion?(nil,err)
                    
                } )
                
                return
            }
            
            completion?(id, err)
            
        })
        
    }
    
}



extension UserWalletViewModel {
    
    
    func updateWalletRemotely(with senderID : String, for user : User, completion : ((Error?)->Void)? = nil ){
        
        let walletToBeUpdated = UserWallet(id : walletHolder.wallet.id ,
        refId: walletHolder.wallet.refId, servicePoSenderId: senderID)
        
       
        // update wallet in session
        DispatchQueue.main.async {
       
            self.walletHolder.wallet.servicePoSenderId = senderID
        }
        
        let walletType = user.allowedWalletTypes.first ?? .personal
        let currency = CurrencyManager.currency(countryCode: user.countryCode ?? Common.defaultCountry) ?? Common.defaultCurrency
        
        // update wallet in KDS
        if var savedWallet = KDS.shared.getWallet(type: walletType, currency: currency){
            
            savedWallet.servicePoSenderId = senderID
            KDS.shared.saveWallet(savedWallet)
        }
       
        
        ARH.shared.updateUserWallet(walletToBeUpdated, returnType: UserWallet.self,  completion: { res in
            
            switch(res) {
            
                case .failure(let err) :
                    completion?(err)
                case .success(_) :
                    
                    completion?(nil)
                    
                   // print("record.tx.to.remote::\(toUserId ?? "zzz")::\(toWalletRefId ?? "xxx")")
                    
            }
        })
        
    }
    
    
    func updateWalletRemotely(payOutTo biller : Biller, user : User,
        amount : Double, number : String, senderId : String? = nil ,
        serviceId : String? = nil , completion : ((Error?) -> Void)? = nil ){
        
        let newBalance = (walletHolder.wallet.balance ?? 0) - amount
        
        var walletToBeUpdated = UserWallet(id : walletHolder.wallet.id ,
        refId: walletHolder.wallet.refId, balance : newBalance)
        
        if walletToBeUpdated.servicePoSenderId == nil, let senderId = senderId {
            
            walletToBeUpdated.servicePoSenderId = senderId
        }
        
        // update wallet in session
        DispatchQueue.main.async {
       
            self.walletHolder.wallet.balance = newBalance
        }
        
        let walletType = user.allowedWalletTypes.first ?? .personal
        let currency = CurrencyManager.currency(countryCode: user.countryCode ?? Common.defaultCountry) ?? Common.defaultCurrency
        
        // update wallet in KDS
        if var savedWallet = KDS.shared.getWallet(type: walletType, currency: currency){
            
            savedWallet.balance = newBalance
            KDS.shared.saveWallet(savedWallet)
        }
        
        // Now update remotely
        ARH.shared.updateUserWallet(walletToBeUpdated, returnType: UserWallet.self,  completion: { res in
            
            switch(res) {
            
                case .failure(let err) :
                    completion?(err)
                    
                case .success(_) :
                    // record a payment tx remotely
                    
                    let note = "\(PH.payBillPrefix)\(number)"
                    
                    self.addPaymentTxRemotely(amount: -amount, currency: currency, user: user,
                    walletRefId: walletToBeUpdated.refId ?? "", toUserId: biller.id ?? "",
                    toUserIdType: .biller_id, toWalletRefId: nil,
                    method: biller.payoutMethod ?? "", note: note, serviceId: serviceId,
                    txType: .payBill, completion: completion)
                    
                   // print("record.tx.to.remote::\(toUserId ?? "zzz")::\(toWalletRefId ?? "xxx")")
                    
            }
        })
        
    }
}

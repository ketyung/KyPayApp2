//
//  WalletHandler.swift
//  KyPay
//
//  Created by Chee Ket Yung on 04/06/2021.
//

import Foundation
import RapydSDK

typealias RWalletType = RapydSDK.RPDWalletType
typealias Gender = RapydSDK.RPDGenderType
typealias ResidenceType = RapydSDK.RPDResidenceType
typealias MaritalStatus = RapydSDK.RPDMaritalStatusType

struct Card {
        
    var number : String = "4111111111111111"
    
    var cvv : String = "123"
    
    var expirationYear : Int = 22
    
    var expirationMonth : Int = 10
    
    var cardType : String.CardType = .none
    
    var paymentTypeBasedOnCardType : String {
        
        switch(cardType){
            
            case .visa :
                return "us_visa_card"
            
            case .master :
                return "us_master_card"
                
            default :
                return ""
        }
    }
}


struct WalletIDs {

    var addrId : String?
    
    var contactId : String?
    
    var custId : String?
    
    var refId : String?
    
    var walletId : String?
    
    var balance : Double?
    
    init(addrId : String?, contactId : String?, custId : String?, refId : String? , walletId : String?){
        
        self.custId = custId
        self.addrId = addrId
        self.contactId = contactId
        self.refId = refId
        self.walletId = walletId
    }
    
    
    fileprivate init(from rpdUser : RPDUser){
        
        self.walletId = rpdUser.id
        self.addrId = rpdUser.contacts?.dataList?.first?.address?.ID
        self.contactId = rpdUser.contacts?.dataList?.first?.ID
        self.refId = rpdUser.eWalletReferenceID
    }
}

class WalletHandler : NSObject {
    
    private let genericMetaData =  ["game": "uncharted"]
    
    private lazy var customerHandler = CustomerHandler()
    

    // also need to create a customer
    func createWallet(for user : User, wallet : UserWallet,
        address : UserAddress? = nil ,completion : ((WalletIDs?, Error?)->Void)? = nil ) {
        
        Config.setup()
        
        let countryCode = user.countryCode ?? Common.defaultCountry
        let phoneNumber = user.phoneNumber ?? ""
        let email = user.email ?? ""
        let walletRefId = wallet.refIdForService ?? ""
        
        let addr = RPDAddress()
        addr.name = address?.id ?? "xxx"
        addr.line1 = address?.line1 ?? "line 1"
        addr.country = RPDCountry.country(isoAlpha2: countryCode)
        addr.city = address?.city ?? "City"
        
        
        let contact = RPDEWalletContactRequestBuilder(contactType: .personal,
        firstName: user.firstName ?? "", lastName: user.lastName ?? "", email: email,
        phoneNumber: phoneNumber, businessDetails: nil,
        dateOfBirth: user.dob ,
        middleName: "",
        secondLastName: "",
        identificationNumber: "100",
        gender: RPDGenderType.male,
        residence: RPDResidenceType.own,
        maritalStatus: .none,
        identificationType: "PA",
        address: addr,
        country: RCountry.country(isoAlpha2: countryCode) )
        
        
        let usersManager = RPDUsersManager()
        
        usersManager.createUser(phoneNumber: phoneNumber,
            eWalletType: self.toRWalletType(wallet), firstName: user.firstName ?? "",
            lastName: user.lastName ?? "", email: email,
            eWalletReferenceID: walletRefId ,
            contact: contact, metadata: genericMetaData, completionBlock:{
            
            usr, error in
            
            if let error = error {
        
                completion?(nil,  error )
                return
            }
                
            if let usr = usr {
                
                if let custId = wallet.serviceCustId {
               
                    var wids = WalletIDs(from: usr)
                    wids.custId = custId
                    completion?(wids, nil)
                }
                else {
                    
                    // we create the customer here ...
                    // add customer here if no customer id present ...
                    self.createCustomer(user: user, wallet: wallet, from: "createWallet", completion: completion)
                 
                }
            
                
            }
            else {
                
                completion?(nil,nil)
            }
            
        })
        
    }
    
    
    
    func updateWallet(with user : User, wallet : UserWallet) {
        
        Config.setup()
       
        let userManager: RPDUsersManager = RPDUsersManager()
        userManager.updateUser(firstName: user.firstName ?? "" ,
                               lastName: user.lastName ?? "",email: user.email ?? "",
                               eWalletReferenceID: wallet.refIdForService ?? "",metadata: genericMetaData) { user, error in
            
            guard let err = error else {
                if let user = user {
                    print("updated::\(user.firstName ?? ""), refId::\(user.eWalletReferenceID ?? "")")
                }
                return
            }
            
            
            print("updating.wallet.err:\(err)")
           
        }
    }
    
    
    private func deleteWallet(){
        
        Config.setup()
       
        let userManager:RPDUsersManager = RPDUsersManager()
    
        userManager.deleteUser(completionBlock: { error in
           
            guard let err = error else {
   
                return
            }
            
            print("deleting.wallet.error:\(err)")
        })
      
    }
    
    private func toRWalletType ( _ wallet : UserWallet) -> RWalletType{
        
        if wallet.type == .personal {
            
            return RWalletType.person
        }
        else if ( wallet.type == .business ){
            
            return RWalletType.company
        }
        
        return RWalletType.person
        
    }
    
}

extension WalletHandler {
    
    
    func detachWallet(){
        
        Config.setup()
       
        RPDUser.detachUser()
    }
    
    func attachWallet(user : User, wallet : UserWallet,
                      toRefreshBalance : Bool = true ,
                      completion : ((WalletIDs?, Error?)->Void)? = nil ){
        
        Config.setup()
       
        let ruser : RPDUser = RPDUser()
        ruser.phoneNumber = user.phoneNumber ?? ""
        ruser.email = user.email ?? ""
        ruser.eWalletReferenceID = wallet.refId ?? ""
    
                    
        let userManager:RPDUsersManager = RPDUsersManager()
        userManager.attachUser(ruser, completionBlock: { [weak self] usr, error in
         
            guard let self = self else { return }
            
            guard let err = error else {
            
                if let usr = usr  {
                
                    if let custId = wallet.serviceCustId {
                        
                        var walletIDs = WalletIDs(from: usr)
                        walletIDs.custId = custId
                        
                        if toRefreshBalance {
                       
                            self.getBalanceOf(completion: { balance , error in
                                
                                walletIDs.balance = balance
                                completion?(walletIDs, error)
                                
                            })
                           
                        }
                        else {
                            
                            completion?(walletIDs,nil)
                        }
                        
                       // print("attaching.wallet.id::\(walletIDs.custId ?? "xxxx")")
                    }
                    else {
                        // add customer here if no customer id present ...
                        self.createCustomer(user: user, wallet: wallet, from: "attachWallet", completion: completion)
                        
                    }
                    
                }
                else {
                    
                    print("attaching.wallet.with.nil.usr")
             
                    completion?(nil, nil)
                }
                
                return
            }
            
            
            completion?(nil,err)
        
            
            
        })
    }
    
    func currentWallet(attachIfNotPresent user : User, wallet : UserWallet,
    toRefreshBalance: Bool = true, completion : ((WalletIDs?, Error?)->Void)? = nil,
    toPrint : Bool = false ){
        
        Config.setup()
       
        if let ruser = RPDUser.currentUser() {
            
            if toPrint {
                
                print("RPD.user::.id::\(ruser.id ?? "")::\(ruser.firstName ?? "") \(ruser.lastName ?? "") : wallet.refId::\(ruser.eWalletReferenceID ?? "xxx") ::balance::")
            }
            
            var walletIDs = WalletIDs(from: ruser)
            
            if toRefreshBalance {
           
                self.getBalanceOf(completion: { balance, error in
               
                    walletIDs.balance = balance
                    
                    completion?(walletIDs, error)
                })
               
            }
            else {
           
                completion?(walletIDs, nil)
            }
            
            
        }
        else {
            
            self.attachWallet(user: user, wallet: wallet, toRefreshBalance: toRefreshBalance, completion: completion)
        }
    }
}

extension WalletHandler {
    
    static let completionURL : String =
        //"http://127.0.0.1:808/KyPay/PaymentSuccess.php"
        
        "https://techchee.com/KyPaySuccess"
    
    static let errorURL : String =
        //"http://127.0.0.1:808/KyPay/PaymentFailed.php"
       
        "https://techchee.com/KyPayFailed"
    
    
    func add(card : Card, amount : Double, currency : String, customerId : String ,
             completion : ((PaymentData?, Error?)->Void)? = nil){
                
        let pmtype = card.paymentTypeBasedOnCardType
        customerHandler.obtainPaymentMethodID(for: customerId, type: pmtype, completion: {

            [weak self] paymentMethodID, error in
            
            if error != nil {
                completion?(nil, error)
                return
            }
            
            guard let self = self else { return }
            
            if let paymentMethodID = paymentMethodID {
           
                self.add(card: card, amount: amount, currency: currency, cardType: pmtype,
                paymentMethodID: paymentMethodID, customerId: customerId,
                completion: completion)
             
            }
            else {
                
                print("Error!!!...unable.2.obtain::paymentMethodID")
            }
            
        })
        
    }
    
    
    private func add(card : Card, amount : Double, currency : String, cardType : String,
                     paymentMethodID : String, customerId : String,
                     completion : ((PaymentData?, Error?)->Void)? = nil ){
        
        
        RPDPaymentMethodManager().fetchPaymentMethodRequiredFields(type: cardType ){ [weak self]
            paymentMethodRequiredFields, error in
    
            guard let self = self else { return }
           
            if error == nil {
                
                let currUser = RPDUser.currentUser()
                let eWallet1 = RPDEWallet(ID: currUser?.id ?? "" , paymentValue: 10, paymentType: .amount)
                
                if var pmfields = paymentMethodRequiredFields {
                   
                    self.setFieldsForCard(&pmfields, card: card)
                    
                    RPDPaymentManager().createPayment(amount: Decimal(amount),
                        currency: RPDCurrency.currency(with: currency),
                        paymentMethodRequiredFields: pmfields,
                        paymentMethodID: paymentMethodID ,
                        eWallets: [eWallet1], completePaymentURL: WalletHandler.completionURL,
                        errorPaymentURL: WalletHandler.errorURL,
                        description: nil,expirationAt: nil, merchantReferenceID: nil,requestedCurrency: nil,
                        isCapture: nil, statementDescriptor: nil,address: nil,customerID: customerId,
                        receiptEmail: currUser?.email ?? "",showIntermediateReturnPage: nil,isEscrow: nil,releaseEscrowDays: nil,
                        paymentFees: nil, metadata: self.genericMetaData){ payment, error in
                            guard let err = error else {
                                
                               var pms = PaymentData()
                               pms.amount = Double(truncating: (payment?.amount ?? 0) as NSNumber)
                               pms.curreny = payment?.currency?.code ?? ""
                               pms.dateCreated = payment?.createdAt
                               pms.status = .created
                               pms.redirectURL = payment?.redirectURL
                               pms.id = payment?.ID
                                
                                
                               completion?(pms, nil)
                               return
                            }
                            
                            completion?(nil, err)
                        }
                
                    }
            
                }
        
                
        }

    }
}

extension WalletHandler {
    
    func add(amount : Double, currency : String, paymentMethod : PaymentMethod,
             customerId : String ,completion : ((PaymentData?, Error?)->Void)? = nil ){
        
        Config.setup()
        
        let pm = paymentMethod.rpdPaymentMethod
        
        self.customerHandler.obtainPaymentMethodID(for: customerId, type: pm.type ?? "", completion: {
            [weak self] paymentMethodID, error in
            
            if error != nil {
                completion?(nil, error)
                return
            }
            
            guard let self = self else { return }
        
            
            if let paymentMethodID = paymentMethodID {
           
                self.add(amount: amount, currency: currency, type: pm.type ?? "",
                paymentMethodID: paymentMethodID, customerId: customerId, completion: completion)

            }
            else {
                
                print("Error!!!...unable.2.obtain::paymentMethodID")
            }
            
        })
            
    }
    
    
    private func add (amount : Double, currency : String, type : String,
    paymentMethodID : String, customerId : String,
    completion : ((PaymentData?, Error?)->Void)? = nil ){
        
        RPDPaymentMethodManager().fetchPaymentMethodRequiredFields(type: type) { [weak self]
            pmfields, error in
            
            if error != nil {
                completion?(nil, error)
                return
            }
            
            guard let self = self else { return }
        
            
            if var pmfields = pmfields {
            
                WalletHandler.setFieldsForOnlineBanking(&pmfields)
        
                let currentUser = RPDUser.currentUser()
                let ewallet1 = RPDEWallet(ID: currentUser?.id ?? "xxx",
                paymentValue: Decimal(amount), paymentType: RPDEWallet.EWalletPaymentType.amount)
                
                
                let pmMgr = RPDPaymentManager()
                
                    
                pmMgr.createPayment(amount: Decimal(amount),
                    currency: RPDCurrency.currency(with: currency),
                    paymentMethodRequiredFields:pmfields,paymentMethodID: paymentMethodID ,
                    eWallets: [ewallet1],completePaymentURL: WalletHandler.completionURL,errorPaymentURL: WalletHandler.errorURL,
                    description: nil,expirationAt: nil,merchantReferenceID: nil,requestedCurrency: nil,isCapture:nil,
                    statementDescriptor: nil,address: nil,customerID: customerId,receiptEmail: currentUser?.email ,
                    showIntermediateReturnPage: nil,isEscrow: nil,releaseEscrowDays: nil,paymentFees: nil,
                    metadata: self.genericMetaData, completionBlock: { payment, err in
                    
                        guard let err = err else {
                    
                         //   print("payment?.completePaymentURL::\(String(describing: payment?.completePaymentURL))")
                            
                           var pms = PaymentData()
                           pms.amount = Double(truncating: (payment?.amount ?? 0) as NSNumber)
                           pms.curreny = payment?.currency?.code ?? ""
                           pms.dateCreated = payment?.createdAt
                           pms.status = .created
                           pms.redirectURL = payment?.redirectURL
                           pms.id = payment?.ID
                        
                            /** For testing url redirection */
                           //pms.redirectURL = URL(string: "http://127.0.0.1:808/KyPay/Test.php")
                            
                           completion?(pms, nil)
                           return
                        }
                        
                        completion?(nil, err)
                    
                })
            }
         
        }
    }
    
}

extension WalletHandler {
    
    static func setFieldsForOnlineBanking (_ pmfields : inout RPDPaymentMethodRequiredFields ){
        
        let user = RPDUser.currentUser()
        
        pmfields.fields.forEach {
            
            
            switch $0.name {
                case "first_name":
                    $0.value = user?.firstName ?? ""
                case "last_name":
                    $0.value = user?.lastName ?? ""
                case "email":
                    $0.value = user?.email ?? ""
                case "complete_payment_url":
                    $0.value = WalletHandler.completionURL
                case "error_payment_url":
                    $0.value = WalletHandler.errorURL
                default:
                    break
            }
        }
        
        //print("set.online.banking.param::\(pmfields.fields)")
        
    }
    
    
   private func setFieldsForCard (_ pmfields : inout RPDPaymentMethodRequiredFields, card : Card ){
        
        pmfields.fields.forEach {
            
            switch $0.name {
                case "number":
                    $0.value = card.number
                case "expiration_month":
                    $0.value = card.expirationMonth
                    
                case "expiration_year":
                    $0.value = card.expirationYear
                    
                case "cvv":
                    $0.value = card.cvv
                    
                default:
                    break
            }
        }
        
    }
}


extension WalletHandler {
    
    
    private func createCustomer( user : User, wallet : UserWallet,
                                 from message : String? = nil,
                                 completion : ((WalletIDs?, Error?)->Void)? = nil){
        
        self.customerHandler.createCustomer(for: user, wallet: wallet, completion: {
            walletIDs , error  in
            
            guard let err = error else {
                
                
                if let message = message {
                    
                    print("creatingCustomer::\(walletIDs?.custId ?? "")::from::\(message)")
                }
               
                completion?(walletIDs, nil)
               
                return
            }
            
            completion?(nil, err)
        })
      
    }
    
    
    
}


extension WalletHandler {
    
    
    func reloadUserData(){
        
        Config.setup()
      
        let userManager:RPDUsersManager = RPDUsersManager()
        userManager.reloadUserData(completionBlock: { user, error in
                      
            
            print("reload.wallet.user?.metadata::\(String(describing: user?.metadata))")
            
        })
    }
    
    private func getBalanceOf(completion : ((Double?, Error?) -> Void)? = nil ){
        
        Config.setup()
        
        let accountManager:RPDAccountsManager = RPDAccountsManager()
        accountManager.userAccounts(completionBlock: { list , error in
            // Enter your code here.
            
            guard let list = list else {
                
                completion?(nil, error)
                return
            }
          
            completion?(list.first?.balance, error)
            
        })
    }
}

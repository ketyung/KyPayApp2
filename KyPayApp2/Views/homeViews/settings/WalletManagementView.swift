//
//  WalletView.swift
//  KyPayApp2
//
//  Created by Christopher Chee on 22/06/2021.
//

import SwiftUI
import RapydSDK

struct WalletManagementView : View {
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel

    @State private var promptDelete : Bool = false

    @State private var walletHandler = WalletHandler()
    
    @State private var custHandler = CustomerHandler()
    
    @State private var custId : String = ""
    
    var body : some View {
        
        VStack(spacing: 50){
            
            
            Button(action: {
                
                let paymentMethod = PaymentMethod(type : "my_cimb_bank")
                
                print("trying...\(paymentMethod.rpdPaymentMethod.type ?? "xxx")")
                walletViewModel.add(amount: 5, paymentMethod:paymentMethod , for: userViewModel.user,
                completion: {
                    err in
                    
                    guard let err = err else {
              
                        print("testing.....x...top.up.succ!!!!")
                  
                        return
                    }
                    print("aaa...xerrr.top.up::\(err)")
              
                    
                })
                
            }){
                
                Text("Test Top up RM5")
            }
            
            
            Button(action : {
              
                if let createdWallet = KDS.shared.getWallet(type: userViewModel.user.allowedWalletTypes.first ?? .personal, currency: userViewModel.allowedCurrency) {
              
                    //walletViewModel.createRapydWallet(user: userViewModel.user, wallet: createdWallet)
                  
                    self.walletHandler.createWallet(for: userViewModel.user, wallet: createdWallet, completion: { ids, err in
                        
                        guard let err = err else {
                            
                            print("wallet.created!!!!")
                            return
                            
                        }
                        
                        print("Create.wallet.from.Rapyd.err:\(err)")
                        
                    })
                }
                
                
              
            }){
                
                Text("Create Wallet")
            }
            
            Button(action: {
                
                if let createdWallet = KDS.shared.getWallet(type: userViewModel.user.allowedWalletTypes.first ?? .personal, currency: userViewModel.allowedCurrency) {
                        
                    self.walletHandler.updateWallet(with: userViewModel.user, wallet: createdWallet)
                }
                
            }){
                
                Text("Update Wallet")
            }
          
            
            Button(action: {
                
                if let createdWallet = KDS.shared.getWallet(type: userViewModel.user.allowedWalletTypes.first ?? .personal, currency: userViewModel.allowedCurrency) {

                    self.walletHandler.attachWallet(user: userViewModel.user, wallet: createdWallet, completion: {
                        
                        ids, err in
            
                        guard let err = err else {
                            
                            print("attaching.wallet::id::\(ids?.walletId ?? "")::cust.id::\(ids?.custId ?? "")")
                            
                            self.custId = ids?.custId ?? "xxxx"
                            return
                        }
                        
                        print("err.attaching.wallet::\(err)")
                    })

                }
                
            }){
                
                Text("Attach Wallet")
            }

            
            Button(action: {
                
                self.walletHandler.detachWallet()
                
            }){
                
                Text("Detach Wallet")
            }

            
            Button(action: {
                
                self.custHandler.delete(customerId: self.custId)
                
            }){
                Text("delete cust")
            }
            
            
            Button(action: {
                
                //my_cimb_bank
                
                self.custHandler.obtainPaymentMethodID(for: "cus_9e0963b6e0db22f4e5d21e80db70952b" , type: "my_cimb_bank",
                completion: { pid, err  in
                
                    guard let err = err else {
                        
                        print("obtained::payment.method.id::\(String(describing: pid))")
                        return
                    }
                
                
                    print("err.obtaining.paymentid::\(err)")
                
                })
            })
            {
                
                Text("Obtain payment method id")
            }
            
        }
        .onAppear{
            
            self.fetchWalletIfNotPresent()
        }
        //WalletHandler().deleteWallet()
    }
}


extension WalletManagementView {
    
    private func fetchWalletIfNotPresent(){
        
        walletViewModel.fetchWalletIfNotPresent(user: userViewModel.user, completion: {
            
            err in
            
            guard let err = err else {
                
                return
            }
            
            print("fetch.wallet.err:\(err)")
        
        })
        
    }
}

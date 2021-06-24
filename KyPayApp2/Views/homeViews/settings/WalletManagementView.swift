//
//  WalletView.swift
//  KyPayApp2
//
//  Created by Christopher Chee on 22/06/2021.
//

import SwiftUI
import RapydSDK

struct WalletManagementView : View {
    
    @ObservedObject private var walletViewModel = UserWalletViewModel()
   
    @EnvironmentObject private var userViewModel : UserViewModel

    @State private var promptDelete : Bool = false

    @State private var walletHandler = WalletHandler()
    
    @State private var custHandler = CustomerHandler()
    
    @State private var custId : String = ""
    
    var body : some View {
        
        VStack(spacing: 50){
            
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
            
        }
        
        //WalletHandler().deleteWallet()
    }
}

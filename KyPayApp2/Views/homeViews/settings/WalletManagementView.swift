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

    
    var body : some View {
        
        VStack(spacing: 50){
            
            Button(action : {
              
                if let createdWallet = KDS.shared.getWallet(type: userViewModel.user.allowedWalletTypes.first ?? .personal, currency: userViewModel.allowedCurrency) {
              
                    //walletViewModel.createRapydWallet(user: userViewModel.user, wallet: createdWallet)
                  
                    WalletHandler().createWallet(for: userViewModel.user, wallet: createdWallet, completion: { ids, err in
                        
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
                        
                    WalletHandler().updateWallet(with: userViewModel.user, wallet: createdWallet)
                }
                
            }){
                
                Text("Update Wallet")
            }
            Button(action: {
                
                self.promptDelete = true
                
            }){
                
                Text("Delete Wallet")
            }
            
            Button(action: {
                
                if let createdWallet = KDS.shared.getWallet(type: userViewModel.user.allowedWalletTypes.first ?? .personal, currency: userViewModel.allowedCurrency) {

                    WalletHandler().attachWallet(user: userViewModel.user, wallet: createdWallet, completion: {
                        
                        ids, err in
                        
                        guard let err = err else {
                            
                            print("attaching.wallet::id::\(ids?.walletId ?? "")::cid::\(ids?.contactId ?? "")")
                            return
                        }
                        
                        print("err.attaching.wallet::\(err)")
                    })

                }
                
            }){
                
                Text("Attach Wallet")
            }

            
            Button(action: {
                
                WalletHandler().detachWallet()
                
            }){
                
                Text("Detach Wallet")
            }

            
        }
        .alert(isPresented: $promptDelete){
            
            Alert(title: Text("Delete Now?"),
                primaryButton: .default(Text("OK")) {
                    WalletHandler().deleteWallet()
                },secondaryButton: .cancel())
        }
        
        //WalletHandler().deleteWallet()
    }
}

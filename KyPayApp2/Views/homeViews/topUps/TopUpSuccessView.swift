//
//  TopUpSuccessView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 25/06/2021.
//

import SwiftUI

struct TopUpSucessView : View {
    
    @EnvironmentObject private var userViewModel : UserViewModel

    @EnvironmentObject private var topUpViewModel : TopUpPaymentViewModel
   
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
   
    
    var body : some View {
        
       view()
        .onAppear{
            // update remote to record a successful payment
            
            walletViewModel.updateWalletRemotely(by: Double(topUpViewModel.amount) ?? 0,
            for: userViewModel.user, method: topUpViewModel.paymentMethod?.type ?? "",
            serviceId:  topUpViewModel.serviceId, 
            completion: { err in
                         
                guard let err = err else {
                    
                    print("updated payment to remote as success")
                    return
                }
                
                print("err:\(err)")
            })
        }
        
    }
}


extension TopUpSucessView {
    
    
    private func view() -> some View {
        
        Common.paymentSuccessView(amount: topUpViewModel.amount,
        balance: walletViewModel.balance, currency: topUpViewModel.currency)
        .padding()
        .navigationBar(title : Text("Top Up Success".localized), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}



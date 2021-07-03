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
    }
}


extension TopUpSucessView {
    
    
    private func view() -> some View {
        
        Common.paymentSuccessView(amount: topUpViewModel.amount,
        balance: walletViewModel.balance, currency: topUpViewModel.currency, subTitle: "Top Up Amount".localized)
        .padding()
        .navigationBar(title : Text("Top Up".localized), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}



//
//  PaymentRedirectView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 26/06/2021.
//

import SwiftUI

struct PaymentRedirectView : View {
    
    let url : URL?
    
    @EnvironmentObject private var topUpViewModel : TopUpPaymentViewModel
   
    @EnvironmentObject private var walletViewModel : UserWalletViewModel

    var body: some View {
        
        view()
    }
}


extension PaymentRedirectView {
    
    @ViewBuilder
    private func view() -> some View {
        
        switch(topUpViewModel.paymentStatus) {
        
            case .success :
            
                TopUpSucessView(topUpViewModel: topUpViewModel, walletViewModel: walletViewModel)
           
            case .failure :
            
                PaymentFailureView()
            
            default :
                webView()
            
        }
    }
    
    
    private func webView() -> some View {
        
        VStack{
    
            PaymentRedirectWebView(url: url)
            .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        }
        .backButton()
    }
}

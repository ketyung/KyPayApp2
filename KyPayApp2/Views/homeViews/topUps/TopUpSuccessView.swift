//
//  TopUpSuccessView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 25/06/2021.
//

import SwiftUI

struct TopUpSucessView : View {
    
    
    var topUpViewModel : TopUpPaymentViewModel
   
    var walletViewModel : UserWalletViewModel
   
    
    var body : some View {
        
        VStack{
            
            Text("Success".localized).font(.custom(Theme.fontName, size: 30))
            
            Image(systemName: "checkmark.circle").resizable().frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit).foregroundColor(Color(UIColor(hex:"#aaff22ff")!))
            
            VStack {
           
                Text("Top-up Amount :".localized)
                .font(.custom(Theme.fontName, size: 20)).foregroundColor(Color(UIColor(hex:"#aaaabbff")!))
               
                Text("\(topUpViewModel.currency) \(topUpViewModel.amount)")
                .font(.custom(Theme.fontName, size: 20)).foregroundColor(Color(UIColor(hex:"#aaaabbff")!))
                   
            }
            
            
            Spacer().frame(height:30)
            
            VStack {
           
                Text("Current Balance :".localized)
                .font(.custom(Theme.fontNameBold, size: 26)).foregroundColor(Color(UIColor(hex:"#999999ff")!))
               
                Text("\(walletViewModel.currency) \(walletViewModel.balance)")
                .font(.custom(Theme.fontNameBold, size: 30)).foregroundColor(Color(UIColor(hex:"#333333ff")!))
                   
            }
            
            Spacer()
              
        }
        .padding()
        .navigationBar(title : Text("Top Up Success".localized), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}



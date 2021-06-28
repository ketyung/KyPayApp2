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



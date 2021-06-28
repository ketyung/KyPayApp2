//
//  PaymentFailureView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 26/06/2021.
//

import SwiftUI

struct TopUpFailureView : View {

   
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
   
    @EnvironmentObject private var topUpViewModel : TopUpPaymentViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel

   
    var body : some View {
        
        VStack{
            
            Text("Failure".localized).font(.custom(Theme.fontName, size: 30))
            
            Image(systemName: "die.face.1").resizable().frame(width: 50, height: 50)
            .aspectRatio(contentMode: .fit).foregroundColor(Color(UIColor(hex:"#ff2233ff")!))
           
            Text("Something Must Have Gone Wrong!!".localized).font(.custom(Theme.fontNameBold, size: 24))
            .foregroundColor(.red)
           
            
            Spacer()
              
        }
        .padding()
        .navigationBar(title : Text("Payment Failure".localized), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            
            // update remote to record a failure payment
            walletViewModel.addPaymentTxRemotely(amount: Double(topUpViewModel.amount) ?? 0, currency: topUpViewModel.currency, user:userViewModel.user, walletRefId: walletViewModel.refId, method: topUpViewModel.paymentMethod?.type ?? "",
                serviceId:  topUpViewModel.serviceId, txType:.walletTopUp, status: .error, completion: { err in
                                                
                guard let err = err else {
                    
                    print("updated payment to remote as failure")
                    return
                }
                
                print("err:\(err)")
            } )
        }
    }

}

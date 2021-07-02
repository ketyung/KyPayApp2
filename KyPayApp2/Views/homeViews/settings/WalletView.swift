//
//  TestWalletView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import SwiftUI
import RapydSDK

struct WalletView : View {
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel

    @State private var promptDelete : Bool = false

    @State private var walletHandler = WalletHandler()
    
    @State private var custHandler = CustomerHandler()
   
    @State private var dataHandler = DataHandler()
   
    @State private var custId : String = ""
    
    @State private var control = PresenterControl()
    
    
    var body : some View {
        
        view()
        .environmentObject(PayoutMethodsViewModel())
        //WalletHandler().deleteWallet()
    }
    
    
    private func view() -> some View {
        
        VStack(alignment:.leading,  spacing: 20){
            
            Spacer().frame(height:20)
            
            walletAmountView()
            
            buttons()
            
            txView()
            
            Spacer()
            
        }
        .navigationBar(title: Text(""), displayMode: .inline)
        .popOver(isPresented: $control.payoutMethodSelectorPresented, content: {
        
            PayoutMethodTypesView(control: $control).frame(height:400)
          
        })
        .onAppear{
            
            self.fetchWalletIfNotPresent()
        }
        .backButton()
    }
}

extension WalletView {
    
    private func walletAmountView() -> some View {
        
        VStack {
       
            Text("Your Wallet").font(.custom(Theme.fontName, size: 26))
            HStack {
                
                Text(walletViewModel.currency).font(.custom(Theme.fontName, size: 20)).foregroundColor(.gray)
                
                Text(walletViewModel.balance).font(.custom(Theme.fontNameBold, size: 40))
            }
        }
        .padding(4)
        .frame(width: UIScreen.main.bounds.width - 40)
        .background(
            
            LinearGradient(gradient: Gradient(colors: [ Color(UIColor(hex:"#ccccccff")!), Color(UIColor(hex:"#d3f4ffff")!)]),
            startPoint: .leading, endPoint: .trailing)
           
        )
        .cornerRadius(10)
        .offset(x: 20)
    }
}



extension WalletView {
    
    
    private func buttons() -> some View {
        
        HStack(spacing: 10){
            
            topUpButton()
            
            withDrawButton()
            
            testButton()
           
        }.padding()
    }
    
    private func topUpButton() -> some View{
        
        Button(action: {
            
        }){
            
            HomeView.buttonView(color : Color(UIColor(hex:"#5566aaff")!), imageOne: "wallet",
                       imageTwo: "plus.circle", text: "Top Up")
        }
        
    }
    
    
    private func withDrawButton() -> some View{
        
        Button(action: {
            
            withAnimation{
                
                self.control.payoutMethodSelectorPresented = true 
            }
        }){
            
            HomeView.buttonView(color : Color(UIColor(hex:"#225533ff")!), imageOne: "withdraw",
                       imageTwo: "minus.circle", text: "Withdraw")
        }
        
    }

    
    
    private func txView() -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Wallet Transactions".localized).font(.custom(Theme.fontNameBold, size: 16))
            
            List{
                
            }
        }.padding()
    }
}


extension WalletView {
    
    private func fetchWalletIfNotPresent(){
        
        walletViewModel.fetchWalletIfNotPresent(user: userViewModel.user, completion: {
            
            err in
            
            guard let err = err else {
                
                return
            }
            
            print("fetch.wallet.err:\(err)")
        
        })
        
    }
    
    
    private func testButton() -> some View {
        
        Button(action: {
            
            //walletHandler.reloadUserData()
            
            //walletHandler.walletAccount()
            
            //dataHandler.supportedPaymentMethods(countryCode: "MY")
            
            //dataHandler.supportedServiceProviders()
            
            dataHandler.supportedPayoutMethods(countryCode: "MY", currency: "MYR")
        }){
            
            Text("Test me!!")
        }
    }
    
}

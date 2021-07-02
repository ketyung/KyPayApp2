//
//  BillerNumberView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 01/07/2021.
//

import SwiftUI
import Kingfisher

struct BillerNumberView : View {
    
    @EnvironmentObject private var paymentViewModel : BillerPaymentViewModel
   
    @EnvironmentObject private var walletViewModel : UserWalletViewModel

    @EnvironmentObject private var userViewModel : UserViewModel
   
    @State private var shouldReset : Bool = true
    
    var body: some View {
        
       view()
    }

}

extension BillerNumberView {
    
    private func view() -> some View {
        
        VStack{
            
            Spacer().frame(height:10)
            
            billerLogo()
            
            accountNumberView()
            
            Spacer().frame(height:20)
            
            amountView()
            
            Spacer()
        }
        .bottomFloatingButton( isPresented: true, action: {
            
   //         paymentViewModel.proceed(from: userViewModel.user, wallet: walletViewMode, walletViewModel: <#T##UserWalletViewModel#>)
    
        })
        .backButton()
        .navigationBar(title: Text(paymentViewModel.biller?.name ?? ""), displayMode: .inline)
        .onDisappear{
            
            if shouldReset {
                paymentViewModel.reset()
            }
        }
    }
}


extension BillerNumberView {
    
    private func accountNumberView() -> some View {
        
        VStack(alignment: .leading, spacing: 2){
       
            let n = billerNumberTitle()
            Text(n).font(.custom(Theme.fontName, size: 16))
            
            TextField(n, text: $paymentViewModel.number)
            .keyboardType(.numberPad)
            .frame(width: 200, height: 24)
            .overlay(VStack{Divider().backgroundFill(.black).offset(x: 0, y: 20)})
            
            
            if paymentViewModel.errorPresented {
            
                Spacer().frame(height: 4)
                Text(paymentViewModel.errorMessage).foregroundColor(.red).font(.custom(Theme.fontName, size: 14))
            }
           
        }
     
    }
    
    @ViewBuilder
    private func amountView() -> some View {
        
        let currency = CurrencyManager.currency(countryCode: paymentViewModel.biller?.country ?? "MY") ?? "MYR"
        let amountTitle = "\("Amount".localized) (\(currency))"
        
        VStack(alignment: .leading, spacing: 2){
       
            Text(amountTitle).font(.custom(Theme.fontNameBold, size: 16)).foregroundColor(Color(UIColor(hex:"#888888ff")!))
            
            TextField("Amount", text: $paymentViewModel.amountText)
            .keyboardType(.decimalPad)
            .frame(width: 200, height: 24).font(.custom(Theme.fontName, size: 30))
            .overlay(VStack{Divider().backgroundFill(.black).offset(x: 0, y: 20)})
            
        }
     
    }
}

extension BillerNumberView  {
    
    private func billerNumberTitle() -> String{
        
        if let bType = paymentViewModel.biller?.byType {
       
            switch(bType) {
            
                case .accountNumber :
                    return "Account Number".localized
                    
                case .phoneNumber :
                    return "Phone Number".localized
                    
                case .others :
                    return "Others".localized
                
            }
        }
        
        return ""
       
    }
    
    
    private func billerLogo() -> some View {
        
        ZStack {
           
            Circle().fill(Color(UIColor(hex:"#aabbccff")!)).frame(width: 120, height: 120).padding()
           
            
            Circle().fill(Color(UIColor(hex:"#eeeeffff")!)).frame(width: 100, height: 100).padding()
            
            
            KFImage( URL(string: paymentViewModel.biller?.iconUrl ?? ""))
            .resizable()
            .loadDiskFileSynchronously()
            .placeholder(Common.imagePlaceHolderView)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .aspectRatio(contentMode: .fit)
            .frame(width: 60)
        
        }.onTapGesture {
            
            UIApplication.shared.endEditing()
        }
    }
    
}

//
//  TopUpPaymentView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import SwiftUI
import Kingfisher

struct TopUpPaymentView : View {

    @EnvironmentObject private var userViewModel : UserViewModel

    @EnvironmentObject private var topUpViewModel : TopUpPaymentViewModel
   
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @State private var inProgress : Bool = false
    
    @State private var errorMessage : String?
    
    @State private var errorPresented : Bool = false
    
    var body : some View {
        
        view()
    }
    
    
    private func view() -> some View {
        
        VStack(alignment: .center,spacing: 20) {
            
            paymentMethodView()
            
            amountView()
            
            balanceView()
            
            Spacer()
            
        }
        .backButton()
        .alert(isPresented: $errorPresented){ Alert(title: Text("Oppps!"),message:Text(errorMessage ?? ""))}
        .navigationBar(title : Text("Enter Amount".localized), displayMode: .inline)
        .bottomFloatingButton( isPresented: topUpViewModel.errorMessage == nil, action: {
            self.topUpNow()
        })
        .progressView(isShowing: $inProgress, text: "")
       
    }
    
    
    private func topUpNow(){
    
        self.endEditing()
        
        self.inProgress = true
        
        if let paymentMethod = topUpViewModel.paymentMethod, let amount =  Double(topUpViewModel.amount), amount > 5 {
       
            walletViewModel.add(amount: amount, paymentMethod:paymentMethod , for: userViewModel.user,
            completion: {
                err in
                
                guard let err = err else {
                    
                    self.inProgress = false
                    self.switchToPaymentSuccess()
                 
                    
                    return
                }
                
                
                self.errorMessage = err.localizedDescription
                self.errorPresented = true
                self.inProgress = false
                
            })
        }
        else {
            
            self.errorMessage = "Invalid Payment Method or Invalid Amount!".localized
            self.errorPresented = true
            self.inProgress = false
        
        }
       
    }
    
    
    private func switchToPaymentSuccess(){
        
        withAnimation(Animation.easeIn(duration: 0.7).delay(0.5)) {
            
            DispatchQueue.main.async {
       
                self.topUpViewModel.paymentSuccess = true
           
            }
        }
    }
    
}

extension TopUpPaymentView  {
    
    private func paymentMethodView() -> some View {
        
        NavigationLink(destination: PaymentMethodTypesView(isPopBack: true)){
        
            HStack(spacing:20) {
                
                Spacer().frame(width:10)
                
                KFImage(topUpViewModel.paymentMethod?.imageURL)
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(placeHolderView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 34)
                
                Text(topUpViewModel.paymentMethod?.name ?? "")
                .font(.custom(Theme.fontName, size: 16))
                
                Spacer()
                
                Image(systemName: "arrow.forward.circle")
                .resizable()
                .frame(width: 20, height:20)
                .foregroundColor(.gray)
                
            }.padding().foregroundColor(.black).background(Color(UIColor(hex:"#eeeeffff")!))
        }
        
    }
    
    
    private func placeHolderView() -> some View {
        
        Image("wallet").resizable().frame(width:26, height: 20).aspectRatio(contentMode: .fit)
    }
}

extension TopUpPaymentView {
    
    private func amountView() -> some View {
        
        VStack {
            
            HStack(alignment: .top) {
           
                Text(userViewModel.allowedCurrency)
                .font(.custom(Theme.fontNameBold, size: 24))
               
                TextField("0", text: $topUpViewModel.amount)
                .keyboardType(.numberPad)
                .font(.custom(Theme.fontName, size: 50))
                .foregroundColor(.gray)
                .frame(width:200)
                
            }.padding()
            
            if let err = topUpViewModel.errorMessage {
                
                Text(err.replace("<curr>", userViewModel.allowedCurrency))
                .font(.custom(Theme.fontName, size: 15))
                .foregroundColor(.red)
            }
            
        }.padding()
    }
    
}


extension TopUpPaymentView {
    
    
    private func balanceView() -> some View {
        
        HStack {
            
            Text("Current Balance:".localized).font(.custom(Theme.fontNameBold, size: 16))
            
            Text("\(walletViewModel.currency)").font(.custom(Theme.fontNameBold, size: 16))
  
            Text("\(walletViewModel.balance)").font(.custom(Theme.fontName, size: 16))
      
        }
        .padding()
        .background(Color(UIColor(hex:"#ddddddff")!))
        .cornerRadius(6)
        
    }
    
 
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

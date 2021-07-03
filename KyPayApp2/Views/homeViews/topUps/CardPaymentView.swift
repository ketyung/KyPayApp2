//
//  CardPaymentView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 24/06/2021.
//

import SwiftUI

struct CardPaymentView : View {
    
    @ObservedObject private var cardViewModel = CardPaymentViewModel()
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
   
    @EnvironmentObject private var userViewModel : UserViewModel
    
    @EnvironmentObject private var topUpViewModel : TopUpPaymentViewModel
   
    @State private var errorMessage : String?
    
    @State private var errorPresented : Bool = false
    
    @State private var inProgress : Bool = false
    
    
    var body: some View {
        
        if topUpViewModel.paymentStatus == .success {
            
           TopUpSucessView()
        }
        else {
       
            view()
           
        }
        
    }
    
    
    private func topUpNow(){
        
        self.endEditing()
        self.inProgress = true 
        
        // tp continue tomorrow
        walletViewModel.add(amount: 10, card: cardViewModel.asCard,  for: userViewModel.user, completion: {
            
            pmdata, err in
            
            guard let err = err else {
                
                self.inProgress = false
                
                self.topUpViewModel.redirectURL = pmdata?.redirectURL
                self.topUpViewModel.servicePaymentId = pmdata?.id
               
                return
            }
            
            
            self.errorMessage = err.localizedDescription
            self.errorPresented = true
            self.inProgress = false
            
        })
    }
   
    
}

extension CardPaymentView {
    
    
    private func view() -> some View {
        
        VStack(spacing:3){
            
            Text("Pay By Card".localized).font(.custom(Theme.fontNameBold, size: 18))
          
            cardInfoView()
          
            amountView()
            
            Spacer().frame(height:100)
            
            Text("Currently, we don't store your card, this is a one-time payment with a card").font(.custom(Theme.fontName, size: 13))
            Spacer()
            
        }
        .padding()
        .bottomFloatingButton( isPresented: cardViewModel.errorMessage == nil, action: {
            self.topUpNow()
        })
        .popOver(isPresented: $errorPresented, content: {
            
            Common.errorAlertView(message: errorMessage ?? "")
        })
        .progressView(isShowing: $inProgress, text: "")
        .onTapGesture {self.endEditing()}
    
    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}



extension CardPaymentView {
    
    private func cardInfoView() -> some View {
        
        
        VStack {
        
            VStack(alignment: .leading){
                
                Text("Card Number".localized).font(.custom(Theme.fontName, size: 16))
                
                HStack(spacing:10) {
                    Image(systemName: "creditcard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26)
                    .foregroundColor(.gray)
              
                    TextField("Card Number".localized, text: $cardViewModel.number)
                    .keyboardType(.numberPad)
                }
               
            }
            
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text("Valid till".localized).font(.custom(Theme.fontName, size: 16))
                    TextField("MM/YY", text : $cardViewModel.expiryDate).keyboardType(.numberPad)
                }
                
                
                VStack(alignment: .leading) {
                
                    Text("CVV".localized).font(.custom(Theme.fontName, size: 16))
                    TextField("CVV", text : $cardViewModel.cvv).keyboardType(.numberPad)
                }
                
            }
        }.padding().border(Color.green).frame(maxHeight:200)
        
    }
    
    private func amountView() -> some View {
        
        VStack(alignment: .leading, spacing:2) {
            
            Text("Amount :".localized).font(.custom(Theme.fontNameBold, size: 20)).foregroundColor(.gray)
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
            
        }.padding(4)
    }
    
}

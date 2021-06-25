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
        
        if topUpViewModel.paymentSuccess {
            
           TopUpSucessView(topUpViewModel: topUpViewModel, walletViewModel: walletViewModel)
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
   
    
    private func switchToPaymentSuccess(){
        
        withAnimation(Animation.easeIn(duration: 0.7).delay(0.5)) {
            
            DispatchQueue.main.async {
       
                self.topUpViewModel.paymentSuccess = true
           
            }
        }
    }
}

extension CardPaymentView {
    
    
    private func view() -> some View {
        
        VStack(spacing:30){
            
            Spacer().frame(height: 30)
            
            
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
            
            
            errorTextView()
            
            Spacer()
            
        }.padding()
        .navigationBar(title : Text("Pay By Card".localized), displayMode: .inline)
        .backButton()
        .bottomFloatingButton( isPresented: cardViewModel.errorMessage == nil, action: {
            self.topUpNow()
        })
        .progressView(isShowing: $inProgress, text: "")
        .onTapGesture {self.endEditing()}
    
    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension CardPaymentView {
    
    
    @ViewBuilder
    private func errorTextView() -> some View {
        
        if let err = cardViewModel.errorMessage {
        
            Text(err).padding().font(.custom(Theme.fontName, size: 13))
            .foregroundColor(.red)
        }
        
    }
}

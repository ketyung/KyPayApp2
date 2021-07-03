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
          
            Spacer().frame(height:10)
            
            amountView()
           
            Spacer().frame(height:10)
           
            proceedButton()
            
            Spacer().frame(height:100)
            
            Text("Currently, we don't store your card yet, this is a one-time payment with a card").font(.custom(Theme.fontName, size: 13))
            Spacer()
            
        }
        .padding()
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
                    SecureField("CVV", text : $cardViewModel.cvv).keyboardType(.numberPad)
                }
                
            }
        }.padding().frame(maxHeight:160).border(Color.green)
        
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
            
        }.padding(4).frame(minWidth : UIScreen.main.bounds.width - 20).border(Color(UIColor(hex:"#aaaaafff")!))
    }
    
    
    
    private func proceedButton() -> some View {
        
        HStack{
        
            Spacer()
            
            Button(action: {
                
                UIApplication.shared.endEditing()
            })
            {
                Text("Proceed")
                .font(.custom(Theme.fontName, size: 20))
                .padding(.leading, 20).padding(.trailing, 20)
                .padding(.top, 6).padding(.bottom, 6)
                .background(Color.green)
                .foregroundColor(.white).cornerRadius(6)
            }
        }
        
    }
    
}

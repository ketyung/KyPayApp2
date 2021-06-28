//
//  SendMoneyView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import SwiftUIX

struct SendMoneyView : View {
        
    @EnvironmentObject private var txInputViewModel : TxInputDataViewModel
    
    //let txInputViewModel : TxInputDataViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @State private var amountText : String = ""
    
    @State private var errorMessage : String?
    
    @State private var errorPresented : Bool = false
    
    @State private var showProgress : Bool = false
    
    @State private var txSuccessful : Bool = false
    
    @State private var isSendButtonPresented : Bool = true

    private var successView : some View {
        
        VStack {
        
            VStack(spacing:2) {
           
                Text("Sent To :").font(.custom(Theme.fontName, size: 16))
                Text("\(txInputViewModel.selectedUserPhoneNumber) \(txInputViewModel.selectedUserName)")
                .font(.custom(Theme.fontName, size: 16))
               
            }
            
            
            Common.paymentSuccessView(amount: amountText,
            balance: walletViewModel.balance, currency: walletViewModel.currency)
            .padding()
            .navigationBarHidden(true)
            .onAppear{
                self.isSendButtonPresented = false
            }
        }
        
        
    }
    
    var body : some View {
        
        if txSuccessful {
            
            txSucessView().onAppear{
                txInputViewModel.clearForRestart()
            }
        }
        else {
            view()
        }
        
    }
}

extension SendMoneyView {
    
    private func view() -> some View {
        
        VStack(alignment: .leading, spacing:20) {
            
            Text("How Much?".localized)
            .font(.custom(Theme.fontNameBold, size: 40))
            .onTapGesture {self.endEditing()}
            
            Spacer()
            .frame(height:30)
            
            amountTextField()
            
            recipientView()
            
            Spacer().frame(height:20)
            
            walletBalanceView()
            
            Spacer()
        }
        .padding(.leading, 20)
        .backButton(additionalAction: {
            self.endEditing()
            self.txInputViewModel.shouldProceedNext = false
        })
        .popOver(isPresented: $errorPresented, content:{
            
            self.errorAlertView()
        })
        .progressView(isShowing: $showProgress)
        .bottomFloatingButton( isPresented: sendButtonPresented(), action: {
    
            self.sendMoneyNow()
        })
    }
    
   
    private func sendButtonPresented() -> Bool {
        
        return isSendButtonPresented && !errorPresented
    }
    
    
    private func errorAlertView() -> some View {
        
        Common.errorAlertView(message: errorMessage ?? "Error!")
       
    }
  
    private func txSucessView() -> some View {
        
        VStack {
       
            HStack {
           
                Spacer()
                
                Button(action: {}){
                
                    Image("more").resizable().frame(width:24, height: 24, alignment: .topTrailing)
                }
                
                Spacer().frame(width: 10)
               
            }
            
            successView
        }
       
      //  .navigationBar(title : Text("Success".localized), displayMode: .inline)
        //.navigationBarBackButtonHidden(true)
    }
    
}

extension SendMoneyView {
    
    private func sendMoneyNow(){
        
        self.endEditing()
        self.showProgress = true

        txInputViewModel.txAmount = Double(amountText) ?? 0
        walletViewModel.sendMoney(from: userViewModel.user,
        to: txInputViewModel.selectedUserPhoneNumber, amount: txInputViewModel.txAmount , completion: { id, err in
            
            guard let err = err else {
            
                self.showProgress = false
                DispatchQueue.main.async {
           
                    withAnimation(.easeInOut(duration: 1.0)) {
                    
                        self.txSuccessful = true
                        self.isSendButtonPresented = false
                    }
                }
                
                return
            }
    
            self.errorMessage = err.localizedDescription
            self.errorPresented = true
            self.showProgress = false
                                        
           // print("self.err::\(self.errorMessage ?? "xxx.e")")
        })
    }
    
}

extension SendMoneyView {
    
    private func amountTextField() -> some View {
    
        HStack {
            Text("\(walletViewModel.currency)").font(.custom(Theme.fontNameBold, size: 18))
            .foregroundColor(.gray)
            
            CocoaTextField("Amount".localized, text: $amountText)
            .keyboardType(.decimalPad)
            .foregroundColor(.black)
            .font(UIFont.boldSystemFont(ofSize: 36))
            .background(Color.white)
            .frame(width: 200, height: 24)
            .overlay(VStack{Divider().backgroundFill(.red).offset(x: 0, y: 26)})
         
        }
        
    }
    
    
    private func recipientView() -> some View{
        
        HStack {
            
            Text(txInputViewModel.selectedUserPhoneNumber)
            .font(.custom(Theme.fontName, size: 18))
            
            Text(txInputViewModel.selectedUserName)
            .font(.custom(Theme.fontName, size: 18))
            
        }.padding()
        
    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension SendMoneyView {
    
    
    private func walletBalanceView() -> some View {
        
        HStack {
        
            Text("Wallet Balance:").font(.custom(Theme.fontName, size: 15))
            
            Text(walletViewModel.currency).font(.custom(Theme.fontName, size: 15))
           
            Text(walletViewModel.balance).font(.custom(Theme.fontName, size: 15))
           
        }
        .padding()
        .background(Color(UIColor(hex:"#ddddddff")!))
        .cornerRadius(10)
        
    }
    

}

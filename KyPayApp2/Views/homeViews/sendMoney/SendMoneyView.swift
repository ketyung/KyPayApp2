//
//  SendMoneyView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import SwiftUIX

struct SendMoneyView : View {
    
    let txInputViewModel : TxInputDataViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @State private var amountText : String = ""
    
    @State private var errorMessage : String?
    
    @State private var errorPresented : Bool = false
    
    @State private var showProgress : Bool = false

    @State private var success : Bool = false
    
    var body : some View {
        
        if success {
            txSucessView()
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
            
            Spacer()
        }
        .padding(.leading, 20)
        .backButton(additionalAction: {
            self.endEditing()
        })
        .popOver(isPresented: $errorPresented, content:{
            
            self.errorAlertView()
        })
        .progressView(isShowing: $showProgress)
        .bottomFloatingButton( isPresented: !(errorPresented), action: {
    
            self.sendMoneyNow()
        })
    }
    
    
    private func txSucessView() -> some View {
        
        Common.paymentSuccessView(amount: txInputViewModel.txAmount.twoDecimalString,
        balance: walletViewModel.balance, currency: walletViewModel.currency)
        .padding()
        .navigationBar(title : Text("Success".localized), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
       
    }
    
    private func errorAlertView() -> some View {
        
        Common.errorAlertView(message: errorMessage ?? "Error!")
       
    }
  
    
}

extension SendMoneyView {
    
    private func sendMoneyNow(){
        
        self.showProgress = true
        walletViewModel.sendMoney(from: userViewModel.user,
        to: txInputViewModel.selectedUserPhoneNumber, amount: txInputViewModel.txAmount, completion: { err in
            
            guard let err = err else {
                
                withAnimation(.easeInOut(duration: 1.0)) {
                        
                    self.showProgress = false
                    self.success = true 
                
                }
                return
            }
    
            self.errorMessage = err.localizedDescription
            self.errorPresented = true
            self.showProgress = false
                                        
        })
    }
    
}

extension SendMoneyView {
    
    private func amountTextField() -> some View {
    
        CocoaTextField("Amount".localized, text: $amountText)
        .keyboardType(.decimalPad)
        .foregroundColor(.black)
        .font(UIFont.boldSystemFont(ofSize: 36))
        .background(Color.white)
        .frame(width: 200, height: 24)
        .overlay(VStack{Divider().backgroundFill(.red).offset(x: 0, y: 26)})
        
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

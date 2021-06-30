//
//  SendMoneyView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import SwiftUIX

struct SendMoneyView : View {
        
    @EnvironmentObject private var txInputViewModel : TxInputDataViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @State private var errorMessage : String?
    
    @State private var errorPresented : Bool = false
    
    @State private var showProgress : Bool = false
    
    @State private var txSuccessful : Bool = false
    
    @State private var isSendButtonPresented : Bool = true
    
    @State private var showShareSheet : Bool = false
    
    @State private var successHiddenTextPresented : Bool = false
    
    @State private var snapshotImages :[Any] = []
    
    
    var body : some View {
        
        if txSuccessful {
            
            txSucessView()
        }
        else {
            view()
        }
        
    }
}

extension SendMoneyView {
    
    private func view() -> some View {
        
        VStack(alignment: .center, spacing:20) {
            
            recipientView()
            
            VStack(alignment: .leading, spacing: 20) {
           
                amountTextField()
            
                walletBalanceView()
               
            }.padding()
            
            messageView()
     
            Spacer().frame(minHeight: 200)
        }
        .padding()
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
        .onTapGesture {self.endEditing()}
     
    }
    
   
    private func sendButtonPresented() -> Bool {
        
        return isSendButtonPresented && !errorPresented
    }
    
    
    private func errorAlertView() -> some View {
        
        Common.errorAlertView(message: errorMessage ?? "Error!")
       
    }
  
    
    private func successView(_ showBalance : Bool = true, withLogo : Bool = false ) -> some View {
        
        VStack {
        
            VStack(spacing:2) {
           
                Text("Sent To :").font(.custom(Theme.fontName, size: 16))
                Text("\(txInputViewModel.selectedUserPhoneNumber) \(txInputViewModel.selectedUserName)")
                .font(.custom(Theme.fontName, size: 16))
               
            }
            
            
            Common.paymentSuccessView(amount: txInputViewModel.txAmountText,
            balance: walletViewModel.balance, currency: walletViewModel.currency,
            showBalance: showBalance, withLogo:  withLogo)
            .padding()
            .navigationBarHidden(true)
            .onAppear{
                self.isSendButtonPresented = false
            }
        }
        
    }
    
    private func txSucessView() -> some View {
        
        VStack {
       
            HStack {
           
                Spacer()
                
                Button(action: {
                    
                    self.shareSnapShot()
                    
                }){
                
                    Image("more").resizable().frame(width:24, height: 24, alignment: .topTrailing)
                }
                
                Spacer().frame(width: 10)
               
            }
            
            if successHiddenTextPresented {
                
                Text("Saved to photo library".localized).font(.custom(Theme.fontName, size: 15))
            }
            
            
            successView()
        }
        .sheet(isPresented: $showShareSheet, content: {
        
            ShareView(activityItems: $snapshotImages)
               
        })
       
      //  .navigationBar(title : Text("Success".localized), displayMode: .inline)
        //.navigationBarBackButtonHidden(true)
    }
    
}

extension SendMoneyView {
    
    private func shareSnapShot(){
        
        let image = successView(false, withLogo: true).padding().snapshot()
        self.snapshotImages = [image]
        withAnimation {

            self.showShareSheet.toggle()
        }
        
    }
    
    
    private func saveSnapShot(){
        
        let image = successView(false).padding().snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            withAnimation{
             
                self.successHiddenTextPresented.toggle()
       
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
               
                    withAnimation{
                     
                        self.successHiddenTextPresented.toggle()
               
                    }
                })
            }
        })
        
        
    }
    
    
    
}

extension SendMoneyView {
    
    private func sendMoneyNow(){
        
        self.endEditing()
        self.showProgress = true

        // txInputViewModel.txAmount = Double(amountText) ?? 0
        
        walletViewModel.sendMoney(from: userViewModel.user,
        to: txInputViewModel.selectedUserPhoneNumber, amount: txInputViewModel.txAmount ,
        toUserId:  txInputViewModel.selectedUserId, toWalletRefId:  txInputViewModel.selectedUserWalletRefId,
        completion: { id, err in
            
            guard let err = err else {
            
                self.showProgress = false
                DispatchQueue.main.async {
           
                    withAnimation(.easeInOut(duration: 1.0)) {
                    
                        self.txSuccessful = true
                        self.isSendButtonPresented = false
                        self.txInputViewModel.shouldProceedNext = true
                        self.txInputViewModel.alertWithSound()
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
    
        VStack(alignment: .leading, spacing: 8) {
       
            Text("How Much?".localized).font(.custom(Theme.fontNameBold, size: 26))
            .foregroundColor(.gray)
       
            HStack {
                Text("\(walletViewModel.currency)").font(.custom(Theme.fontNameBold, size: 18))
                .foregroundColor(.gray)
                
                CocoaTextField("Amount".localized, text: $txInputViewModel.txAmountText)
                .keyboardType(.decimalPad)
                .foregroundColor(.black)
                .font(UIFont.boldSystemFont(ofSize: 46))
                .background(Color.white)
                .frame(width: 200, height: 24)
                .overlay(VStack{Divider().backgroundFill(.red).offset(x: 0, y: 26)})
             
            }
           
        }
        
    }
    
    
    private func recipientView() -> some View{
        
        HStack {
            
            Text("To: ".localized)
            .font(.custom(Theme.fontName, size: 18))
               
            Text(txInputViewModel.selectedUserPhoneNumber)
            .font(.custom(Theme.fontName, size: 18))
            
            Text(txInputViewModel.selectedUserName)
            .font(.custom(Theme.fontName, size: 18))
            
        }.padding()
        
    }
    
    
    private func messageView() -> some View{
       
        VStack(alignment: .leading, spacing: 2) {
            
            Text("Note :".localized)
            .font(.custom(Theme.fontNameBold, size: 18))
       
            TextField("message", text: $txInputViewModel.note)
            .frame(width: 260, height: 24)
            .overlay(VStack{Divider().backgroundFill(.black).offset(x: 0, y: 20)})
             
            
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

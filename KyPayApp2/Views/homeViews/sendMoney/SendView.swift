//
//  SendView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUIX

struct SendView : View {
    
    @ObservedObject private var dataInputViewModel = PhoneInputViewModel()
  
    @ObservedObject private var txInputViewModel = TxInputDataViewModel()
    
    @State private var recentAttempts : [CachedRecentTxAttempt] = []
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    
    var body: some View {
        
        navView()//.environmentObject(txInputViewModel)
    }
    
    
    private func navView() -> some View {
        
        NavigationView {
        
            view()
            .padding(.leading, 20)
            .navigationBarHidden(true)
              
        }
        .popOver(isPresented: $dataInputViewModel.isCountryPickerPresented){
        
            CountryCodePickerUI(viewModel: dataInputViewModel, textFont: .custom(Theme.fontName, size: 15))
        }
        .popOver(isPresented: $txInputViewModel.showAlert, content: {
        
            errorAlertView()
        })
        .progressView(isShowing: $txInputViewModel.showProgressIndicator, text: "Syncing contacts...",
            size:  CGSize(width:200, height: 200))
        .bottomFloatingButton( isPresented: self.sendButtonPresented() , action: {
            
            self.verifyPhoneNumberAndProceed()
            
        })
        .popOver(isPresented: $txInputViewModel.txSuccessful, content: {
            
            txSucessView()
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    private func sendButtonPresented() -> Bool {
        
        return (!dataInputViewModel.isCountryPickerPresented && !txInputViewModel.showAlert && !txInputViewModel.shouldProceedNext)
    }
}

extension SendView {
    

    private func view() -> some View {
        
        VStack(alignment: .leading, spacing:20) {
            
            Spacer()
            .frame(height:30)
            
            Text("Send Money")
            .font(.custom(Theme.fontNameBold, size: 40))
            .onTapGesture {self.endEditing()}
            
            Spacer()
            .frame(height:30)
            
            Text("Mobile Phone")
            .font(.custom(Theme.fontName, size: 20))
            .foregroundColor(Color(UIColor(hex:"#36A600ff")!))
            
            
            phoneView()
            
            
            recentAttemptsView()
            
            Spacer()
            
            sendMoneyViewNavLink()
            
        }
    }
}

extension SendView {
    
    private func phoneView() -> some View {
        
        HStack(alignment: .center,spacing:10) {
            
            Spacer().frame(width:10)
            
            phoneViewWithDialCode()
           
            contactButton()
            
            Spacer()
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 10 ,height: 30)
    }
    
    private func phoneViewWithDialCode() -> some View {

        HStack(spacing:2) {
    
            dialCodeButton()
            
            phoneTextField()
            .onTapGesture {
                dataInputViewModel.phoneNumberIsFirstResponder = true
            }

        }
        .frame(height: 30)
  
    }
    
    
    private func phoneTextField() -> some View {
    
        CocoaTextField("Phone Number".localized, text: $dataInputViewModel.enteredPhoneNumber)
        .isFirstResponder(dataInputViewModel.phoneNumberIsFirstResponder)
        .keyboardType(.numberPad)
        .foregroundColor(.black)
        .font(UIFont.boldSystemFont(ofSize: 26))
        .background(Color.white)
        .frame(width: 200, height: 24)
        .overlay(VStack{Divider().backgroundFill(.red).offset(x: 0, y: 26)})
        
    }
    
}


extension SendView {
    
    private func errorAlertView() -> some View {
        
        Common.errorAlertView(message: txInputViewModel.alertMessage)
    }
   
    
    @ViewBuilder
    private func dialCodeButton() -> some View {
        
        Button(action: {
            
            withAnimation{
           
                dataInputViewModel.isCountryPickerPresented = true
                dataInputViewModel.phoneNumberIsFirstResponder = false
            }
            
        }){
            
            Text(dataInputViewModel.selectedCountry?.dialCode ?? "+60")
            .foregroundColor(.black)
            .font(Font.system(size: 20, design: .rounded))
            .frame(width: 60, height: 24)
            .lineLimit(1)
   
        }
        
       
    }
    
    private func selectedCountryImage() -> UIImage? {
        
        if let country = dataInputViewModel.selectedCountry {
            
            return country.flag
        }
        
        return UIImage(named: "CountryPickerView.bundle/Images/MY")
    }
    

}

extension SendView {
    
    
    @ViewBuilder
    private func contactButton() -> some View {
        
        
        if txInputViewModel.phoneNumberBeingVerified {
            
            ActivityIndicator()
            .frame(width: 30)
            .foregroundColor(.gray)
            
        }
        else {
       
            
            Button(action: {
                
                self.endEditing()
                self.syncContact()
                
            }){
                
                ZStack {
                    
                    Rectangle().fill(Color(UIColor(hex:"#9999bbff")!)).cornerRadius(6).frame(width: 30)
                
                    Image(systemName: "person.fill")
                    .foregroundColor(.white)
                }
                
            }
        }
        
       
    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
        self.dataInputViewModel.phoneNumberIsFirstResponder = false 
    }
    
    
    private func txSucessView() -> some View {
        
        Common.paymentSuccessView(amount: txInputViewModel.txAmount.twoDecimalString,
        balance: walletViewModel.balance, currency: walletViewModel.currency)
        .padding()
        .navigationBar(title : Text("Success".localized), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
    
}

extension SendView {
    
    private func syncContact(){
        
        txInputViewModel.syncContact()
    }
    
    
    private func verifyPhoneNumberAndProceed(){
        
        self.endEditing()
        
        let phoneNumber = "\(dataInputViewModel.selectedCountry?.dialCode ?? "+60")\(dataInputViewModel.enteredPhoneNumber)"
        
        txInputViewModel.verifyIfPhoneNumberExists(phoneNumber)
        
    }
    
    private func sendMoneyViewNavLink() -> some View {
        
        NavigationLink(destination: SendMoneyView(txInputViewModel: txInputViewModel), isActive : $txInputViewModel.shouldProceedNext){}.hidden(true)
    }

}


extension SendView {
    
    private func recentAttemptsView() -> some View {
        
        VStack(alignment: .leading, spacing: 2) {
            
            Spacer().frame(height:100)
            
            if recentAttempts.count > 0 {
            
                Text("Recent").font(.custom(Theme.fontNameBold, size: 15))
                
                List (recentAttempts, id:\.phoneNumber){ a in
                    
                    Button (action : {
                        
                        if  let numberOnly = a.phoneNumber?.replace(dataInputViewModel.selectedCountry?.dialCode ?? "+60", ""){
                  
                            dataInputViewModel.enteredPhoneNumber = numberOnly
                
                        }
                    }){
                    
                        HStack {
                            
                            Text(a.phoneNumber ?? "Phone").font(.custom(Theme.fontName, size: 15))
                            .foregroundColor(.gray)
                            
                            Text(a.name ?? "Name").font(.custom(Theme.fontName, size: 15))
                            .foregroundColor(.gray)
                        
                            Spacer()
                            
                            Common.disclosureIndicator()
                        }
                    }
                    
                }
            }
            
        }
        .onAppear{
                
            self.recentAttempts = txInputViewModel.fetchRecentAttempts()
        }
    }
}

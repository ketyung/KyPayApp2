//
//  TopUpView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import SwiftUI


struct TopUpView : View {
    
    @Binding var control : PresenterControl
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel
   
    @State private var errorMessage : String?
    
    @State private var errorMessagePresented : Bool = false 
    
    
    var body: some View {
            
        view()
        .backButton()
        .progressView(isShowing: $walletViewModel.progressIndicatorPresented, text: "Fetching wallet...".localized)
       .alert(isPresented: $errorMessagePresented){ Alert(title: Text("Oppps!"),message:Text(errorMessage ?? ""))}
       .onAppear{self.fetchWalletIfNotPresent()}
       
    }
}

extension TopUpView {
    
    private func view() -> some View {
        
        VStack(spacing: 20){
            
            closeButton()
            
            Spacer().frame(height:30)
            

            Text("Available top-up methods".localized)
            .font(.custom(Theme.fontName, size: 18))
            .padding()
            .neumo()
            
            Spacer().frame(height:20)
            
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                
            
                Button (action: {
                    
                    withAnimation{
                   
                        self.control.topUpPresented = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:{
                          
                            self.control.paymentMethodSelectorPresented = true 
                        })
                    }
                    
                }){
                
                    HStack(spacing:20)  {
                        
                        Image(systemName: "house.circle")
                        .resizable()
                        .frame(width:30, height: 30)
                        .foregroundColor(.orange)
                    
                        Text("Online Banking".localized)
                        .font(.custom(Theme.fontName, size: 16))
                        
                        Spacer()
                          
                    }.padding()
                  
                }
                
                
                
                NavigationLink (destination: CardPaymentView()){
                
                    
                    HStack(spacing:20) {
                        
                        Image(systemName: "creditcard.circle")
                        .resizable()
                        .frame(width:30, height: 30)
                        .foregroundColor(.green)
                    
                        Text("Cards".localized)
                        .font(.custom(Theme.fontName, size: 16))
                        
                        Spacer()
                    }.padding()
                    
                }
            }
            
            
        }.padding()
    }
}


extension TopUpView {
    
    
    private func closeButton() -> some View {
        
        HStack(spacing:5) {
       
            Spacer()
            .frame(width:2)
            
            Button(action: {
                withAnimation {
                    self.control.topUpPresented = false
                }
            }){
                
                Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width:20, height: 20, alignment: .topLeading)
                .foregroundColor(.black)
                
            }
            
            Spacer()
        }
        
    }
    
    
    private func fetchWalletIfNotPresent(){
        
        walletViewModel.fetchWalletIfNotPresent(user: userViewModel.user, completion: {
            
            err in
            
            guard let err = err else {
                
                return
            }
            
            withAnimation{
                
                self.errorMessagePresented = true
                self.errorMessage = err.localizedDescription
            }
        })
        
    }

    
    
    
}

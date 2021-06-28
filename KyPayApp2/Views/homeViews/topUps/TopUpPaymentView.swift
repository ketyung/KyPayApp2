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
    
    @State private var pushToNext : Bool = false
    
    @State private var dismissTopBar : Bool = false
    
    @Binding var control : PresenterControl

    
    
    var body : some View {
        
        NavigationView {
   
            view()
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    private func view() -> some View {
        
        VStack(alignment: .center,spacing: 20) {
            
            topBar()
            
            paymentMethodView()
            
            amountView()
            
            balanceView()
            
            Spacer()
            
            nextScreenNavLink()
            
        }
        .alert(isPresented: $errorPresented){ Alert(title: Text("Oppps!"),message:Text(errorMessage ?? ""))}
        .bottomFloatingButton( isPresented: topUpViewModel.errorMessage == nil, action: {
            self.topUpNow()
        })
        .progressView(isShowing: $inProgress, text: "")
       
    }
    
    
    private func topUpNow(){
    
        withAnimation{
       
            self.dismissTopBar = true
        }
        
        self.endEditing()
        
        self.inProgress = true
        
        
        if let paymentMethod = topUpViewModel.paymentMethod, let amount =  Double(topUpViewModel.amount), amount > 5 {
       
            let user = userViewModel.user
            walletViewModel.add(amount: amount, paymentMethod:paymentMethod ,for: user,
            completion: {
                pmdata, err in
                
                guard let err = err else {
                    
                
                    self.inProgress = false
                   
                    self.topUpViewModel.redirectURL = pmdata?.redirectURL
                    
                    self.topUpViewModel.servicePaymentId = pmdata?.id
                    
                    withAnimation {
                        
                        self.pushToNext = true
                    }
                    
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
    
}

extension TopUpPaymentView  {
    
    private func paymentMethodView() -> some View {
        
        NavigationLink(destination: PaymentMethodTypesView(isPopBack: true, control: $control)){
        
            HStack(spacing:20) {
                
                //Spacer().frame(width:10)
                
                KFImage(topUpViewModel.paymentMethod?.imageURL)
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(placeHolderView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 34)
                
                Text(topUpViewModel.paymentMethod?.name ?? "")
                .font(.custom(Theme.fontName, size: 15))
                .frame(minWidth: 200, alignment: .leading)
                   
                Spacer()
                
                Common.disclosureIndicator()
                
            }.padding().foregroundColor(.black).background(Color(UIColor(hex:"#eeeeeeff")!))
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
    
    private func nextScreenNavLink() -> some View {
        
        NavigationLink(destination:PaymentRedirectView(url: topUpViewModel.redirectURL),
        isActive : $pushToNext){}.hidden(true)
    }
    
    
    
    
    
    @ViewBuilder
    private func topBar() -> some View {
        
        
        if !dismissTopBar {
       
            HStack {
           
                closeButton()
                
                Text("Enter Amount".localized).font(.custom(Theme.fontName, size: 18))
                
                Spacer().frame(minWidth: 100)
                
            }
           
        }
    }
    
    private func closeButton() -> some View {
    
        HStack(spacing:5) {
       
            Spacer()
            .frame(width:2)
            
            Button(action: {
                withAnimation {
                    self.control.topUpPaymentPresented = false
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
}

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
    
    var body : some View {
        
        VStack(alignment: .center,spacing: 20) {
            
            paymentMethodView()
            
            amountView()
            
            Spacer()
            
        }
        .backButton()
        //.navigationTitle("Enter Amount".localized)
        .navigationBar(title : Text("Enter Amount".localized), displayMode: .inline)
        .bottomFloatingButton( isPresented: topUpViewModel.errorMessage == nil, action: {})
        
    }
    
}

extension TopUpPaymentView  {
    
    private func paymentMethodView() -> some View {
        
        NavigationLink(destination: PaymentMethodTypesView(isPopBack: true)){
        
            HStack(spacing:20) {
                
                Spacer().frame(width:10)
                
                KFImage(topUpViewModel.paymentMethod?.imageURL)
                .resizable()
                .placeholder(placeHolderView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 34)
                
                Text(topUpViewModel.paymentMethod?.name ?? "")
                .font(.custom(Theme.fontName, size: 16))
                
                Spacer()
                
                Image(systemName: "arrowtriangle.forward.fill")
                .resizable()
                .frame(width: 20, height:20)
                .foregroundColor(.gray)
                
            }.padding().foregroundColor(.black).background(Color(UIColor(hex:"#ddeeffff")!))
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

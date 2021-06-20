//
//  TopUpPaymentView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import SwiftUI
import Kingfisher

struct TopUpPaymentView : View {

    let paymentMethod : PaymentMethod
    
    @EnvironmentObject private var userViewModel : UserViewModel

    @ObservedObject private var topUpViewModel = TopUpPaymentViewModel()
    
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
        
        NavigationLink(destination: PaymentMethodTypesView()){
        
            HStack(spacing:20) {
                
                Spacer().frame(width:10)
                
                KFImage(paymentMethod.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 34)
                
                Text(paymentMethod.name ?? "")
                .font(.custom(Theme.fontName, size: 16))
                
                Spacer()
            }.padding().foregroundColor(.black).background(Color(UIColor(hex:"#ddeeffff")!))
        }
        
    }
}

extension TopUpPaymentView {
    
    private func amountView() -> some View {
        
        VStack {
            
            HStack(alignment: .top) {
           
                Text(userViewModel.allowedCurrency)
                .font(.custom(Theme.fontNameBold, size: 24))
               
                TextField("0", text: $topUpViewModel.topUpAmount)
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

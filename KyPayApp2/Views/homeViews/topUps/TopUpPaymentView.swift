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
        
        VStack {
            
            paymentMethodView()
            
            amountView()
            
            Spacer()
            
        }
        .backButton()
    }
    
}

extension TopUpPaymentView  {
    
    private func paymentMethodView() -> some View {
        
        NavigationLink(destination: PaymentMethodTypesView()){
        
            HStack {
                
                KFImage(paymentMethod.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 34)
                
                Text(paymentMethod.name ?? "")
                .font(.custom(Theme.fontName, size: 16))
                
            }
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
                .keyboardType(.decimalPad)
                .font(.custom(Theme.fontName, size: 50))
                .foregroundColor(.gray)
                .frame(width:200)
                
            }.padding()
            
            
            
        }
    }
}

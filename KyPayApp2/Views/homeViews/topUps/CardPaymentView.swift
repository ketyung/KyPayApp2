//
//  CardPaymentView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 24/06/2021.
//

import SwiftUI

struct CardPaymentView : View {
    
    @ObservedObject private var cardViewModel = CardPaymentViewModel()
    
    var body: some View {
        
        VStack(spacing:30){
            
            Spacer().frame(height: 30)
            
            
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
                    TextField("CVV", text : $cardViewModel.cvv).keyboardType(.numberPad)
                }
                
            }
            
            Spacer()
            
        }
        .padding()
        .navigationBar(title : Text("Pay By Card".localized), displayMode: .inline)
        .backButton()
       
    }
    
}

//
//  PaymentMethodTypesView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import SwiftUI
import Kingfisher

struct PaymentMethodTypesView : View {
    
    @EnvironmentObject private var userViewModel : UserViewModel
   
    @ObservedObject private var pmViewModel = PaymentMethodsViewModel()
    
    var body: some View {
        
        VStack {
            
            List{
                
                ForEach(pmViewModel.supportedPaymentMethods, id:\.type){
                    pm in
                    
                    
                    HStack {
                   
                        KFImage(pm.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                       
                        
                        Text(pm.name ?? "")
                        .font(.custom(Theme.fontName, size: 18))
                        .padding()
                       
                    }
                    
                }
                
            }
            
        }
        .onAppear{

            pmViewModel.fetchSupportedPaymentMethods(countryCode: userViewModel.countryCode)
           //fetchSupportedPaymentMethods()
        }
    }
}


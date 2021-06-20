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
                    
                    paymentMethodRow(pm)
                    
                }
            }
            .frame(height:500)
            Spacer()
            
        }
        .backButton()
        .onAppear{

            pmViewModel.fetchSupportedPaymentMethods(countryCode: userViewModel.countryCode)
           //fetchSupportedPaymentMethods()
        }
        .progressView(isShowing: $pmViewModel.showLoadingIndicator, text: "", size: CGSize(width:100,height: 100), showGrayOverlay: false)
        .navigationBar(title: Text("Select Online Banking / e-Wallet".localized), displayMode: .inline)
    }
}


extension PaymentMethodTypesView {
    
    
    private func paymentMethodRow (_ paymentMethod : PaymentMethod) -> some View {
        
      
        NavigationLink(
            destination: TopUpPaymentView(paymentMethod: paymentMethod))
        {
       
            HStack {
           
                KFImage(paymentMethod.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
                   
               
                
                Text(paymentMethod.name ?? "")
                .font(.custom(Theme.fontName, size: 16))
                .padding()
               
            }
        }
       
        
    }
}

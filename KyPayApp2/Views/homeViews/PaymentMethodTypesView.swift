//
//  PaymentMethodTypesView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import SwiftUI
import Kingfisher

struct PaymentMethodTypesView : View {
    
    @Binding var isPresented : Bool
    
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
            
        }
        .onAppear{

            pmViewModel.fetchSupportedPaymentMethods(countryCode: userViewModel.countryCode)
           //fetchSupportedPaymentMethods()
        }
        .progressView(isShowing: $pmViewModel.showLoadingIndicator, text: "", size: CGSize(width:100,height: 100), showGrayOverlay: false)
        
    }
}


extension PaymentMethodTypesView {
    
    
    private func paymentMethodRow (_ paymentMethod : PaymentMethod) -> some View {
        
      
        HStack {
       
            KFImage(paymentMethod.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40)
               
           
            
            Text(paymentMethod.name ?? "")
            .font(.custom(Theme.fontName, size: 16))
            .padding()
           
        }
        .onTapGesture {
            
            withAnimation {
           
                pmViewModel.selectedPaymentMethod = paymentMethod
                self.isPresented.toggle()
                
            }
      
        }
        
    }
}

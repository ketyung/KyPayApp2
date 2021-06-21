//
//  PaymentMethodTypesView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import SwiftUIX
import Kingfisher

struct PaymentMethodTypesView : View {
    
    @EnvironmentObject private var userViewModel : UserViewModel
   
    @EnvironmentObject private var topUpViewModel : TopUpPaymentViewModel
    
    @EnvironmentObject private var pmViewModel : PaymentMethodsViewModel
    
    var isPopBack : Bool = false
    
    @State private var pushToPayment : Bool = false
    
    @Environment(\.presentationMode) private var presentation
    
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
            
            topUpPaymentLink()
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
    
    
    @ViewBuilder
    private func paymentMethodRow (_ paymentMethod : PaymentMethod) -> some View {
        
    
        Button(action :{
   
            topUpViewModel.paymentMethod = paymentMethod
            
            if isPopBack {
                self.presentation.dismiss()
            }
            else {
                
                self.pushToPayment = true
            }
            
        }){
            
            toPaymentMethodView(paymentMethod)
        }
            
    }
    
    
    private func toPaymentMethodView(_ paymentMethod : PaymentMethod) -> some View {
        
        HStack {
       
            KFImage(paymentMethod.imageURL)
            .resizable()
            .placeholder(placeHolderView)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .aspectRatio(contentMode: .fit)
            .frame(width: 40)
               
           
            
            Text(paymentMethod.name ?? "")
            .font(.custom(Theme.fontName, size: 16))
            .padding()
           
        }
    }
    
    private func placeHolderView() -> some View {
        
        ActivityIndicator().frame(width:30, height: 30)
    }
    
    private func topUpPaymentLink() -> some View {
        
        NavigationLink(destination: TopUpPaymentView(), isActive : $pushToPayment){}.hidden(true)
    }
}

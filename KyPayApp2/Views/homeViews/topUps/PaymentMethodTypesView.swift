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
    
    @Binding var control : PresenterControl

    
    @Environment(\.presentationMode) private var presentation
    
    var body: some View {
        
        VStack {
            
            closeButton()
            
            List{
                
                ForEach(pmViewModel.supportedPaymentMethods, id:\.type){
                    pm in
                    
                    paymentMethodRow(pm)
                    
                }
            }
            .frame(height:UIScreen.main.bounds.height - 240)
            
            Spacer()
            
        }
        .backButton()
        .onAppear{

            pmViewModel.fetchSupportedPaymentMethods(countryCode: userViewModel.countryCode)
           //fetchSupportedPaymentMethods()
        }
        .progressView(isShowing: $pmViewModel.showLoadingIndicator, text: "", size: CGSize(width:100,height: 100), showGrayOverlay: false)
        .navigationBar(title: Text("Select Online Banking".localized), displayMode: .inline)
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
                
                self.close()
            }
            
        }){
            
            toPaymentMethodView(paymentMethod)
        }
            
    }
    
    
    private func toPaymentMethodView(_ paymentMethod : PaymentMethod) -> some View {
        
        HStack {
       
            KFImage(paymentMethod.imageURL)
            .resizable()
            .loadDiskFileSynchronously()
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
        ZStack {
   
            Circle().fill(Color(UIColor(hex:"#bbbbccff")!)).frame(width: 32, height: 32)
            
            ActivityIndicator().frame(width:24, height: 24).tintColor(.white)
        }
    }
    
    
}

extension PaymentMethodTypesView {
    
    private func closeButton() -> some View {
        
        HStack(spacing:5) {
       
            Spacer()
            .frame(width:2)
            
            Button(action: {
                    
                self.close()
                
            }){
                
                Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width:20, height: 20, alignment: .topLeading)
                .foregroundColor(.black)
                
            }
            
            Spacer()
        }
        
    }
    
    
    private func close(){
        
        withAnimation{
       
            self.control.paymentMethodSelectorPresented = false
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
                self.control.topUpPaymentPresented = true
            })
        }
    
    }
}

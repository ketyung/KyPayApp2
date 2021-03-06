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

    var otherAction : ((_ selectedPaymentMethod : PaymentMethod?)->Void)? = nil
    
    @Environment(\.presentationMode) private var presentation
    
    var body: some View {
        
        VStack {
            
            
            if !isPopBack {
           
                HStack {
           
                    closeButton()
               
                    Text("Select Online Banking".localized).font(.custom(Theme.fontName, size: 16))
                     .frame(minWidth: 200)
                
                    Spacer().frame(minWidth: 30)
                
                }
            }
       
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
   
            // if other action is provided, use other action
            // and don't set to topUpViewModel 
            if let action = otherAction {
                
                action(paymentMethod)
            }
            else {
                
                topUpViewModel.paymentMethod = paymentMethod
                
                if isPopBack {
                    self.presentation.dismiss()
                }
                else {
                    
                    self.select()
                }
               
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
            .placeholder(Common.imagePlaceHolderView)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .aspectRatio(contentMode: .fit)
            .frame(width: 30)
               
           
            
            Text(paymentMethod.name ?? "")
            .font(.custom(Theme.fontName, size: 15))
            .frame(minWidth: 240, alignment: .leading)
            .padding()
           
            
            Spacer()
            NavigationLink.empty
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
    
    private func select(){
        
        withAnimation{
       
            self.control.paymentMethodSelectorPresented = false
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
                self.control.topUpPaymentPresented = true
            })
            
           
        }
    
    }
    
    private func close(){
        
        withAnimation{
       
            self.control.paymentMethodSelectorPresented = false
           
            self.control.topUpPaymentPresented = false
        }
    
    }
}

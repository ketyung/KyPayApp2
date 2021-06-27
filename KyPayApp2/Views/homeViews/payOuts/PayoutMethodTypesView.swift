//
//  PayoutMethodsView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 27/06/2021.
//

import SwiftUIX
import Kingfisher

struct PayoutMethodTypesView : View {
    
    @EnvironmentObject private var userViewModel : UserViewModel
   
    @EnvironmentObject private var pmViewModel : PayoutMethodsViewModel
    
    var isPopBack : Bool = false
    
    @Binding var control : PresenterControl

    
    @Environment(\.presentationMode) private var presentation
    
    var body: some View {
        
        VStack {
            
            
            if !isPopBack {
           
                HStack {
           
                    closeButton()
               
                    Text("Select Payout Method".localized).font(.custom(Theme.fontName, size: 16))
                     .frame(minWidth: 200)
                
                    Spacer().frame(minWidth: 30)
                
                }
            }
       
            List{
                
                ForEach(pmViewModel.supportedPayoutMethods, id:\.type){
                    pm in
                    
                    paymentMethodRow(pm)
                    
                }
            }
            .frame(height:UIScreen.main.bounds.height - 240)
            
            Spacer()
            
        }
        .backButton()
        .onAppear{

            pmViewModel.fetchSupportedPayoutMethods(countryCode: userViewModel.countryCode, currency: userViewModel.allowedCurrency)
           //fetchSupportedPayoutMethods()
        }
        .progressView(isShowing: $pmViewModel.showLoadingIndicator, text: "", size: CGSize(width:100,height: 100), showGrayOverlay: false)
        .navigationBar(title: Text("Select Payout Option".localized), displayMode: .inline)
    }
}


extension PayoutMethodTypesView {
    
    
    @ViewBuilder
    private func paymentMethodRow (_ paymentMethod : PayoutMethod) -> some View {
        
    
        Button(action :{
   
           // topUpViewModel.paymentMethod = paymentMethod
            
            if isPopBack {
                self.presentation.dismiss()
            }
            else {
                
                self.select()
            }
            
        }){
            
            toPayoutMethodView(paymentMethod)
        }
            
    }
    
    
    private func toPayoutMethodView(_ paymentMethod : PayoutMethod) -> some View {
        
        HStack {
       
            KFImage(paymentMethod.imageURL)
            .resizable()
            .loadDiskFileSynchronously()
            .placeholder(placeHolderView)
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
    
    private func placeHolderView() -> some View {
        ZStack {
   
            Circle().fill(Color(UIColor(hex:"#bbbbccff")!)).frame(width: 32, height: 32)
            
            ActivityIndicator().frame(width:24, height: 24).tintColor(.white)
        }
    }
    
    
}

extension PayoutMethodTypesView {
    
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
       
            self.control.payoutMethodSelectorPresented = false
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
                self.control.topUpPaymentPresented = true
            })
        }
    
    }
    
    private func close(){
        
        withAnimation{
       
            self.control.payoutMethodSelectorPresented = false
           
            self.control.topUpPaymentPresented = false
        }
    
    }
}

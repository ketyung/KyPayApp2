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
    
    @Binding var control : PresenterControl

    
    @Environment(\.presentationMode) private var presentation
    
    var body: some View {
        
        VStack {
            
            Spacer().frame(height: 20)
           
            Text("Available Payout Methods".localized).font(.custom(Theme.fontName, size: 16)).padding(4)
           
           
            List{
                
                ForEach(pmViewModel.supportedPayoutMethods, id:\.type){
                    pm in
                    
                    paymentMethodRow(pm)
                    
                }
            }
            
            Spacer()
            
        }
        .backButton()
        .onAppear{

            pmViewModel.fetchSupportedPayoutMethods(countryCode: userViewModel.countryCode, currency: userViewModel.allowedCurrency)
           //fetchSupportedPayoutMethods()
        }
        .progressView(isShowing: $pmViewModel.showLoadingIndicator, text: "", size: CGSize(width:100,height: 100), showGrayOverlay: false)
    }
}


extension PayoutMethodTypesView {
    
    
    @ViewBuilder
    private func paymentMethodRow (_ paymentMethod : PayoutMethod) -> some View {
        
        Button(action :{
   
            self.select()
        }){
            
            toPayoutMethodView(paymentMethod)
        }
            
    }
    
    
    private func toPayoutMethodView(_ paymentMethod : PayoutMethod) -> some View {
        
        HStack (alignment: .center){
       
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
            .frame(minWidth: 160, alignment: .leading)
            .padding()
           
            
            Text(paymentMethod.payoutCurrencies?.first ?? "")
                .font(.custom(Theme.fontName, size: 15)).foregroundColor(.gray)
            .frame(minWidth: 50, alignment: .leading)
            .padding()
        
            NavigationLink.empty
        }
    }
    
    
}

extension PayoutMethodTypesView {
    
    
    private func select(){
        
        withAnimation{
       
            self.control.payoutMethodSelectorPresented = false
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
                self.control.topUpPaymentPresented = true
            })
        }
    
    }
    
   
}

//
//  BillersSelectionView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 01/07/2021.
//

import SwiftUI
import Kingfisher

struct BillersSelectionView : View {
    
    @ObservedObject private var billersViewModel = BillersViewModel()
    
    @State private var paymentViewModel = BillerPaymentViewModel()
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    @State private var shouldProceed : Bool = false
    
    
    var body: some View {
        
        NavigationView {
        
            VStack{
                
               // Text("Choose a biller").font(.custom(Theme.fontName, size: 18))
                
                List(billersViewModel.billers, id:\.id) { biller in
                    
                    billerRow(biller)
                }
            
                paymentNavLink()
            }
            .navigationBar(title: Text("Choose A Biller"), displayMode: .inline)
        }
        
        .popOver(isPresented: $billersViewModel.errorPresented , content: {
            
            Common.errorAlertView(message: billersViewModel.errorMessage)
        })
        .progressView(isShowing: $billersViewModel.showProgressIndicator)
        .onAppear{
            billersViewModel.fetchBillers(country: userViewModel.countryCode)
        }
        .environmentObject(paymentViewModel)
    }
}


extension BillersSelectionView {
    
    
    private func billerRow( _ biller : Biller ) -> some View{
        
       
        Button(action: {
            
            paymentViewModel.biller = biller
            
            withAnimation{
                
                self.shouldProceed = true
            }
    
        }){
            HStack {
                
                KFImage( URL(string: biller.iconUrl ?? ""))
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(Common.imagePlaceHolderView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
            
                Text(biller.name ?? "")
                .font(.custom(Theme.fontName, size: 15))
                .frame(minWidth: 160, alignment: .leading)
                .padding()
                
            }
           
        }
    }
    
    
    private func paymentNavLink() -> some View {
        
        NavigationLink(destination: BillerNumberView(), isActive : $shouldProceed){}.hidden(true)
    }

}

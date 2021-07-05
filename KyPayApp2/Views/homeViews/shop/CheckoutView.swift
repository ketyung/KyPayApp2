//
//  CheckoutView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 05/07/2021.
//

import SwiftUI

struct CheckoutView : View {
    
    @EnvironmentObject private var cartViewModel : CartViewModel
   
    var body : some View {
        
        VStack{
   
            Text("Check Out".localized).font(.custom(Theme.fontNameBold, size: 20))
            
            List{
                
                ForEach(cartViewModel.itemSellers, id:\.self){
                    
                    sellerId in
                    
                    let sectionText = Text(sellerId).fixedSize(horizontal: false, vertical: true).lineLimit(1).font(.custom(Theme.fontNameBold, size: 15))
                    
                    Section(header: sectionText ) {
                    
                   
                        if let items = cartViewModel.itemsBySeller[sellerId] {
                            
                            itemRows(items)
                            
                            subTotalView(seller: sellerId)
                        }
                    }
                }
                
                totalView()
            }
            
            
        }
    }
}

extension CheckoutView {
    
    

    private func itemRows ( _ items : [CartItem]) -> some View {
        
    
        ForEach(items, id:\.item.id) {
            
            item in
        
            itemRow(item)
            
        }
    
    }
    
    
    private func itemRow (_ item : CartItem) -> some View {
        
        NavigationLink (destination: EmptyView()){
            
            HStack {
          
                Text(item.item.name ?? "").font(.custom(Theme.fontNameBold, size: 15))
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true).lineLimit(3).frame(maxWidth:160)
              
                Text("\(item.item.currency ?? "") \(item.item.price?.twoDecimalString ?? "") x \(item.quantity) = \(item.subTotal.twoDecimalString)")
                .font(.custom(Theme.fontName, size: 16))
            
                Spacer()
            
            }
            
        }
        
    }
    
}

extension CheckoutView {
    
    
    @ViewBuilder
    private func subTotalView ( seller : String) -> some View  {
        
        var currency = Common.defaultCurrency
        let subTotal = cartViewModel.subTotalAmountBy(seller: seller, currency: &currency)
        
        HStack {
            
            Spacer()
            
            Text("\("Sub-total".localized) : \(currency) \(subTotal.twoDecimalString)")
            .font(.custom(Theme.fontNameBold, size: 15))
            
        }
    }
    
    @ViewBuilder
    private func totalView() -> some View {
        
        var currency = Common.defaultCurrency
        let total = cartViewModel.totalAmount(currency: &currency)
        
        HStack {
            
            Spacer()
      
            Text("\("Total".localized) : \(currency) \(total.twoDecimalString)")
            .font(.custom(Theme.fontNameBold, size: 15))
      
            
        }
    }
}


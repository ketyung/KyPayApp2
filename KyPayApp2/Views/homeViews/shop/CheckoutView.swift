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
            
            List (cartViewModel.itemSellers, id:\.self){
                
                sellerId in
                
                Section(header: Text(sellerId).font(.custom(Theme.fontNameBold, size: 16))) {
                
               
                    if let items = cartViewModel.itemsBySeller[sellerId] {
                        
                        itemRows(items)
                    }
                   
                }
                
            }
            
            
        }
    }
}

extension CheckoutView {
    
    private func itemRows ( _ items : [CartItem]) -> some View {
        
        VStack(alignment : .leading, spacing: 3) {
       
        
            ForEach(items, id:\.item.id) {
                
                item in
            
                itemRow(item)
                
            }
        }
        
    }
    
    
    private func itemRow (_ item : CartItem) -> some View {
        
        HStack {
      
            Text(item.item.name ?? "").font(.custom(Theme.fontName, size: 16))
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true).lineLimit(3).frame(width:100)
          
            Text("\(item.item.currency ?? "") \(item.item.price?.twoDecimalString ?? "")")
            .font(.custom(Theme.fontName, size: 16))
            
            Text(" x \(item.quantity)")
            .font(.custom(Theme.fontName, size: 16))
        
            Text(" = \(item.subTotal)")
            .font(.custom(Theme.fontName, size: 16))
            
            Spacer()
        
        }
        
    }
}


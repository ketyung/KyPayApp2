//
//  CartView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import SwiftUI
import Kingfisher

struct CartView : View {

    @EnvironmentObject private var cartViewModel : CartViewModel
    
    var body : some View {
        
        ScrollView([], showsIndicators : false ){
            
            Text("Your Shopping Cart").font(.custom(Theme.fontNameBold, size: 24))
            
            List(cartViewModel.cartItems, id:\.item.id) {
                    
                cartItem in
                
                itemRowView(cartItem)
    
            }.padding()
        
        }
    }
}

extension CartView {
    
    private func itemRowView ( _ cartItem : CartItem ) -> some View {
        
        HStack {
            
            KFImage( URL(string: cartItem.item.images?.first?.url ?? ""))
            .resizable()
            .loadDiskFileSynchronously()
            .placeholder(Common.imagePlaceHolderView)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .padding(.leading, 20)
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            
            
            Text(cartItem.item.name ?? "").font(.custom(Theme.fontName, size:18)).padding(.leading, 2)
            .fixedSize(horizontal: false, vertical: true).lineLimit(3)
            //.frame(width: 200)
            
            
            Text("\(cartItem.quantity)").font(.custom(Theme.fontNameBold, size:18)).padding()
            .foregroundColor(.black)
            
            Image(systemName: "plus.circle.fill")
            .resizable().frame(width:34, height:34).aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .onTapGesture {
                withAnimation {
            
                    cartViewModel.add(item: cartItem.item)
                }
            }
            
                   
            Image(systemName: "minus.circle.fill")
            .resizable().frame(width:34, height:34).aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .onTapGesture {
                
                withAnimation{
         
                    cartViewModel.remove(item: cartItem.item)
                }
            }
            
            Spacer()
         
        }
    }
}


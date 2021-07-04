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
            
            ScrollView(.vertical,showsIndicators : false ){
            
                ForEach(cartViewModel.cartItems, id:\.item.id) {
                        
                    cartItem in
                    
                    itemRowView(cartItem)
        
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 10)
        
            Button(action: {}){
                
                Text("Check Out".localized).font(.custom(Theme.fontNameBold, size: 20)).padding(6).frame(width: 200)
                .background(IDV.buttonBgColor).foregroundColor(.white)
                .cornerRadius(6)
            }
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
            
            
            Text(cartItem.item.name ?? "").font(.custom(Theme.fontName, size:16)).padding(.leading, 2)
            .fixedSize(horizontal: false, vertical: true).lineLimit(3)
            .frame(width: 200)
            
            Spacer().frame(width:10)
            
            cartActionButtons(cartItem: cartItem)
            
        }
    }
}


extension CartView {
    
    
    private func cartActionButtons(cartItem : CartItem) -> some View {
        
        HStack(spacing:10) {
            
            Text("\(cartItem.quantity)").font(.custom(Theme.fontNameBold, size:15)).padding()
            .foregroundColor(.white).background(IDV.buttonBgColor).frame(minWidth:55)
            
            Image(systemName: "plus.circle.fill")
            .resizable().frame(width:30, height:30).aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .onTapGesture {
                withAnimation {
            
                    cartViewModel.add(item: cartItem.item)
                }
            }
            
                   
            Image(systemName: "minus.circle.fill")
            .resizable().frame(width:30, height:30).aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .onTapGesture {
                
                withAnimation{
         
                    cartViewModel.remove(item: cartItem.item)
                }
            }
        }
        
    }
}

//
//  ItemDetailsView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import SwiftUI
import Kingfisher

struct ItemDetailsView : View {
    
    
    @Binding var control : PresenterControl
    
    @EnvironmentObject private var itemsViewModel : SellerItemsViewModel

    @EnvironmentObject private var cartViewModel : CartViewModel

    @State private var cartViewPresented : Bool = false
    
    var body: some View {
        
        ScrollView([], showsIndicators: false) {
            
            topBar()
            
            ScrollView(.vertical, showsIndicators: false) {
        
                itemView(itemsViewModel.selectedItem)
                
            }
            .padding()
            .frame(maxHeight: UIScreen.main.bounds.height - 220)
            
            Spacer()//.frame(minHeight: 20)
       
        }
        .popOver(isPresented: $cartViewPresented, content: {
            
            CartView().frame(width: UIScreen.main.bounds.width - 10)
        })
        .animation(.easeIn)
        
    }
    
}

extension ItemDetailsView {
    
    @ViewBuilder
    private func itemView( _ item : SellerItem?) -> some View {
        
        if let item = item {
       
            VStack(alignment: .leading, spacing: 8) {
           
                Text(item.name ?? "").font(.custom(Theme.fontNameBold, size: 20)).padding(.leading, 2)
                .fixedSize(horizontal: false, vertical: true).lineLimit(3)
                .frame(width: UIScreen.main.bounds.width - 60)
               
                
                KFImage( URL(string: item.images?.first?.url ?? ""))
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(Common.imagePlaceHolderView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .padding(.leading, 20)
                .aspectRatio(contentMode: .fit)
                .frame(width: 240)
                
                
                
                HStack {
                    Text("Price :").font(.custom(Theme.fontNameBold, size: 16)).padding(6)
                    Text("\(item.currency ?? Common.defaultCurrency) \(item.price?.twoDecimalString ?? "0.00")")
                    .font(.custom(Theme.fontName, size: 18))
                    
                    cartActionButton()
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 20)
                .padding().border(Color.green, width: 1, cornerRadius: 6)
                
                
                VStack(alignment: .leading, spacing: 2) {
                
                    Text("Description :".localized).font(.custom(Theme.fontNameBold, size: 18))
                    
               
                    Text(item.description ?? "").font(.custom(Theme.fontName, size: 20)).padding(6)
                    .fixedSize(horizontal: false, vertical: true).lineLimit(20)
                    .frame(minWidth: UIScreen.main.bounds.width - 60)
                   
                }
                .padding(.leading, 1).padding(.leading, 10)
                .padding(.top, 6).padding(.bottom, 10)
                .border(Color.purple, width: 1, cornerRadius: 6)
                
                
                Button(action:{}){
               
                    HStack {
                        
                        Image(systemName: "info.circle.fill").resizable()
                        .foregroundColor(.white).frame(width:24, height:24).aspectRatio(contentMode: .fit)
                        
                        Text("Seller Info").font(.custom(Theme.fontName, size: 18)).foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(8)
                    .frame(maxWidth: 160, maxHeight: 50, alignment: .trailing)
                    .background(IDV.buttonBgColor)
                    .cornerRadius(10)
               
                }
               
                
            
            }.padding(.leading, 10).padding(.bottom, 8).padding(.top, 8)
           
        }
        else {
            
            Text("No Item Selected!")
        }
        
        
    }
}


typealias  IDV = ItemDetailsView

extension ItemDetailsView {
    
    
    static let buttonBgColor : Color = Color(UIColor(hex:"#226655ff")!)
    
    
    private func cartActionButton() -> some View {
        
        HStack(spacing: 50) {
            
            Button(action: {
                
                if let item = itemsViewModel.selectedItem {
         
                    cartViewModel.add(item: item)
                }
            }){
            
                ZStack {
               
                    Circle().fill(Color.green).frame(width:36,height:36)
                    
                    Image(systemName: "cart.fill.badge.plus")
                    .resizable().frame(width:24).aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                   
                }
                
            }
            
            
            Button(action: {
                
                
                if let item = itemsViewModel.selectedItem {
         
                    cartViewModel.remove(item: item)
                }
                
            }){
            
                    
                ZStack {
               
                    Circle().fill(Color.red).frame(width:36,height:36)
                    
                    Image(systemName: "cart.fill.badge.minus")
                    .resizable().frame(width:24).aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                   
                }
            }
        }
        .padding(8)
        .frame(maxWidth: 160)
        .background(Color.purple)
        .cornerRadius(20)
       
    }
}

extension ItemDetailsView {
    
    private func cartBadge() -> some View {
        
        Button(action :{
            
            withAnimation{
                
                self.cartViewPresented = true 
            }
            
        }){
      
            HStack {
        
                Text("\(cartViewModel.total())").font(.custom(Theme.fontNameBold, size: 20)).foregroundColor(.white)
                    
                Image(systemName: "cart.fill").resizable()
                .foregroundColor(.white).frame(width:24, height:20).aspectRatio(contentMode: .fit)
            
            }
            .padding(8)
            .frame(maxWidth: 80, maxHeight: 50, alignment: .trailing)
            .background(IDV.buttonBgColor)
            .cornerRadius(20)
          
       
        }
      
    }
    
    
    private func topBar() -> some View {
        
        HStack {
            
            Button(action: {
                
                withAnimation {
                
                    control.itemDetailsPresented = false
                    
                }
                
            }){
                
                Image(systemName: "x.circle.fill").resizable().foregroundColor(Color.black).frame(width:30, height:30)
            }
            
            Spacer()
            
            cartBadge()
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
        .padding(.top, 6)
        .padding(.bottom, 6)
        .frame(maxHeight:55)
        
    }
    
}

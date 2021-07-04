//
//  SellerItemsView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import SwiftUI
import Kingfisher

struct SellerItemsView : View {
    
    @Binding var control : PresenterControl
    
    @EnvironmentObject private var itemsViewModel : SellerItemsViewModel

    @EnvironmentObject private var userViewModel : UserViewModel
   
    var body: some View {
        
        view()
        
    }
    
    
    private func view() -> some View {
        
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(alignment: .leading, spacing: 3){
            
                Text("KyShop - shop here for great items").font(.custom(Theme.fontNameBold, size: 18))
                
                ForEach(itemsViewModel.categoryKeys, id:\.self){
                    cat in
                    
                    Text(cat).font(.custom(Theme.fontNameBold, size: 18))
                    .padding(4)
                    //.frame(width: UIScreen.main.bounds.width - 10)
                    .frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                    .background(Color(UIColor(hex:"#ddeeddff")!))
                        
                    if let items = itemsViewModel.byCategories[cat] {
                        
                        itemsView(items)
                    }
                }
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 10)
        .onAppear{
            
            itemsViewModel.fetchSellerItems(currency: userViewModel.allowedCurrency)
        }
    }
}


extension SellerItemsView {
    
    
    private func itemsView (_ items : [SellerItem]) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false){
        
            HStack (spacing:3) {
            
                ForEach(items, id:\.id) { item in
                    
                    itemView(item)
                }
            }
            
        }
        
    }
    
    
    private func itemView(_ item : SellerItem ) -> some View {
        
        Button(action : {
            
            
            withAnimation{
                
                itemsViewModel.selectedItem = item
                
                control.itemDetailsPresented.toggle()
            }
            
        }){
        
            
            VStack(spacing:3) {
                
                Text(item.name ?? "").font(.custom(Theme.fontName, size: 16)).foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true).lineLimit(3).frame(width:100)
                
                KFImage( URL(string: item.images?.first?.url ?? ""))
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(placeHolderImageView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
            
            }.padding(6)
            .frame(width:140,height:200)
        }
        
    }
    
    
    private func placeHolderImageView() -> some View {
        
        Image("logo").resizable().frame(width:80).aspectRatio(contentMode: .fit)
    }
}
